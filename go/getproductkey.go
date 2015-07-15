// https://github.com/a8m/go-lang-cheat-sheet
// http://www.howtogeek.com/206329/how-to-find-your-lost-windows-or-office-product-keys/
// https://gist.github.com/Spaceghost/877110
// https://gist.github.com/eyecatchup/d577a2628666a0ad1375

package main

import (
	// "bytes"
	// "encoding/binary"
	"fmt"
	"golang.org/x/sys/windows/registry"
	"log"
	// "reflect"
	// "strconv"
	// "math"
)

func DecodeKey(rpk []byte) {
	fmt.Printf("DigitalProductId [% x] Length: %d\n", rpk, len(rpk))
	fmt.Printf("DigitalProductId [%s] Length: %d\n", rpk, len(rpk))
	fmt.Printf("DigitalProductId [%q] Length: %d\n", rpk, len(rpk))
	fmt.Printf("DigitalProductId [%+q] Length: %d\n", rpk, len(rpk))
	fmt.Printf("DigitalProductId ")
	for i := 0; i < len(rpk); i++ {
		fmt.Printf("[%d]%x ", i, rpk[i])
	}
	fmt.Println()

	editionBytes := rpk[36:45]
	fmt.Printf("editionBytes: [% x] Length: %d\n", editionBytes, len(editionBytes))
	fmt.Printf("editionBytes: [%q] Length: %d\n", editionBytes, len(editionBytes))
	productId := rpk[8:31]
	fmt.Printf("productId: [% x] Length: %d\n", productId, len(productId))
	fmt.Printf("productId: [%q] Length: %d\n", productId, len(productId))
	fmt.Println()

	const keyStartIndex = 52
	const keyEndIndex = keyStartIndex + 15
	// alphaNumericGEnericKeys := []rune{
	// 	'B', 'C', 'D', 'F', 'G', 'H', 'J', 'K', 'M', 'P', 'Q', 'R',
	// 	'T', 'V', 'W', 'X', 'Y', '2', '3', '4', '6', '7', '8', '9',
	// }
	// fmt.Printf("alphaNumericGEnericKeys: %q Length: %d\n", alphaNumericGEnericKeys, len(alphaNumericGEnericKeys))
	const decodeLength = 29
	const decodedStringLength = 15

	const rpkOffset = 52
	i := 28
	szPossibleChars := "BCDFGHJKMPQRTVWXY2346789"
	szProductKey := ""

	for i >= 0 {
		dwAccumulator := 0
		j := 14
		for j >= 0 {
			dwAccumulator = dwAccumulator * 256
			//log.Println(rpk[j+rpkOffset])
			//log.Printf("[% x]\n", rpk[j+rpkOffset])

			//d = rpk[j+rpkOffset]
			// if isinstance(d, str):
			//     d = ord(d)
			// dwAccumulator = d + dwAccumulator
			// rpk[j+rpkOffset] =  (dwAccumulator / 24) if (dwAccumulator / 24) <= 255 else 255

			// d := rpk[j+rpkOffset]
			// fmt.Println(reflect.TypeOf(d))         // uint8
			// fmt.Println(reflect.ValueOf(d).Kind()) // uint8

			j -= 1
		}

		i -= 1
		// log.Println(string(szPossibleChars[dwAccumulator]))
		szProductKey = string(szPossibleChars[dwAccumulator]) + szProductKey

		if ((29-i)%6) == 0 && i != -1 {
			i -= 1
			szProductKey = "-" + szProductKey
		}
	}
	fmt.Println()
	log.Println(szProductKey)

}

func main() {
	k, err := registry.OpenKey(registry.LOCAL_MACHINE, `SOFTWARE\Microsoft\Windows NT\CurrentVersion`, registry.QUERY_VALUE)
	if err != nil {
		log.Fatal(err)
	}
	defer k.Close()

	productId, _, err := k.GetBinaryValue("DigitalProductId")
	if err != nil {
		log.Fatal(err)
	}
	// fmt.Printf("DigitalProductId is [% x].\n", productId)
	DecodeKey(productId)

}
