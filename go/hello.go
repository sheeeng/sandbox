package main

import "fmt"

func main() {
	fmt.Printf("Hello, Go 世界!\n")
	fmt.Printf("%s\n", `( ꒪Д꒪)ノ`)
	fmt.Printf("%s\n", `☆*･゜ﾟ･*\(^O^)/*･゜ﾟ･*☆`)
	fmt.Printf("%s\n", `٩(^ᴗ^)۶`)
	fmt.Println(len("Hello World"))
	fmt.Println("Hello World"[1])
	fmt.Println("Hello " + "World")

	const loremIpsum string = "Lorem Ipsum"
	fmt.Println(loremIpsum)

	fmt.Print("Enter a number: ")
	var input float64
	fmt.Scanf("%f", &input)
	output := input * 2
	fmt.Println(output)

	count := 1
	for count <= 10 {
		fmt.Println(count)

		if count%2 == 0 {
			fmt.Println("Even")
		} else {
			fmt.Println("Odd")
		}

		switch count {
		case 0:
			fmt.Println("Zero")
		case 1:
			fmt.Println("One")
		case 2:
			fmt.Println("Two")
		case 3:
			fmt.Println("Three")
		case 4:
			fmt.Println("Four")
		case 5:
			fmt.Println("Five")
		default:
			fmt.Println("Unknown Number")
		}

		count += 1
	}

	var pizzaSlices [5]int
	pizzaSlices[4] = 40
	fmt.Println(pizzaSlices)

	var total int = 0
	for i := 0; i < len(pizzaSlices); i++ {
		total += pizzaSlices[i]
	}
	fmt.Println(total / len(pizzaSlices))
}
