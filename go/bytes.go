// http://blog.golang.org/slices
// http://blog.golang.org/strings

package main

import (
	"fmt"
	"unicode/utf8"
)

func main() {
	fmt.Println("Hello Go!")

	const sample = "\xbd\xb2\x3d\xbc\x20\xe2\x8c\x98"
	fmt.Println(sample)

	for i := 0; i < len(sample); i++ {
		fmt.Printf("%x ", sample[i])
	}

	fmt.Println()

	fmt.Printf("%x\n", sample)
	fmt.Printf("% x\n", sample)
	fmt.Printf("%q\n", sample)
	fmt.Printf("%+q\n", sample)

	slicedItem := sample[:6]

	fmt.Println("Printf with %+q:")
	fmt.Printf("%+q\n", slicedItem)

	const placeOfInterest = `⌘`

	fmt.Printf("plain string: ")
	fmt.Printf("%s", placeOfInterest)
	fmt.Printf("\n")

	fmt.Printf("quoted string: ")
	fmt.Printf("%+q", placeOfInterest)
	fmt.Printf("\n")

	fmt.Printf("hex bytes: ")
	for i := 0; i < len(placeOfInterest); i++ {
		fmt.Printf("%x ", placeOfInterest[i])
	}
	fmt.Printf("\n")

	const nihongo = "日本語"
	for index, runeValue := range nihongo {
		fmt.Printf("%#U starts at byte position %d\n", runeValue, index)
	}
	for i, w := 0, 0; i < len(nihongo); i += w {
		runeValue, width := utf8.DecodeRuneInString(nihongo[i:])
		fmt.Printf("%#U starts at byte position %d\n", runeValue, i)
		w = width
	}

	const emoji = `(っ ºДº)っ ︵ ⌨`
	for index, runeValue := range emoji {
		fmt.Printf("%#U starts at byte position %d\n", runeValue, index)
	}

	fmt.Printf("%x\n", emoji)
	fmt.Printf("% x\n", emoji)
	fmt.Printf("%q\n", emoji)
	fmt.Printf("%+q\n", emoji)

}
