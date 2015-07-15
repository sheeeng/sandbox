package main

import (
	"crypto/sha256"
	"fmt"
	"log"
	"net"
	"os"
	"os/user"
	"runtime"
	"time"
)

func UserHomeDir() string {
	// http://stackoverflow.com/a/7922977/4763512
	if runtime.GOOS == "windows" {
		home := os.Getenv("HOMEDRIVE") + os.Getenv("HOMEPATH")
		if home == "" {
			home = os.Getenv("USERPROFILE")
		}
		return home
	}
	return os.Getenv("HOME")
}

func SntpNow(host string) (*time.Time, error) {
	// https://play.golang.org/p/6KRE-2Hq6n
	raddr, err := net.ResolveUDPAddr("udp", host+":123")
	if err != nil {
		return nil, err
	}

	data := make([]byte, 48)
	data[0] = 3<<3 | 3

	con, err := net.DialUDP("udp", nil, raddr)
	if err != nil {
		return nil, err
	}

	defer con.Close()

	_, err = con.Write(data)
	if err != nil {
		return nil, err
	}

	con.SetDeadline(time.Now().Add(5 * time.Second))

	_, err = con.Read(data)
	if err != nil {
		return nil, err
	}

	var sec, frac uint64
	sec = uint64(data[43]) | uint64(data[42])<<8 | uint64(data[41])<<16 | uint64(data[40])<<24
	frac = uint64(data[47]) | uint64(data[46])<<8 | uint64(data[45])<<16 | uint64(data[44])<<24

	nsec := sec * 1e9
	nsec += (frac * 1e9) >> 32

	obtainedNtpTime := time.Date(1900, 1, 1, 0, 0, 0, 0, time.UTC).Add(time.Duration(nsec)).Local()

	if obtainedNtpTime.Year() > 2014 {
		fmt.Println("After 2014.")	
	} else {
		fmt.Println("2014 or earlier.")
	}
	 

	fmt.Printf("[% x]\n", data)
	fmt.Printf("%d\n", len(data))

	return &obtainedNtpTime, nil
}

func main() {
	homeDir := UserHomeDir()
	fmt.Printf("%s\n", homeDir)

	usr, err := user.Current()
	if err != nil {
		log.Fatal(err)
	}
	fmt.Printf("%s\n", usr)
	fmt.Printf("%s\n", usr.Uid)
	fmt.Printf("%s\n", usr.Gid)
	fmt.Printf("%s\n", usr.Username)
	fmt.Printf("%s\n", usr.Name)
	fmt.Printf("%s\n", usr.HomeDir)

	usrSha := sha256.New()
	usrSha.Write([]byte(usr.Uid))
	usrShaHex := usrSha.Sum(nil)
	fmt.Printf("%x\n", usrShaHex)

	emoji := `☆*･゜ﾟ･*\(^O^)/*･゜ﾟ･*☆`

	usrSha = sha256.New()
	usrSha.Write([]byte(usr.Uid + emoji))
	usrShaHex = usrSha.Sum(nil)
	fmt.Printf("%x\n", usrShaHex)

	tntp, err := SntpNow("0.pool.ntp.org")
	if err != nil {
		fmt.Printf("ERROR: %v\n", err)
		return
	}

	fmt.Printf("Network time: %v\n", tntp)
	fmt.Printf("System time: %v\n", time.Now())
}
