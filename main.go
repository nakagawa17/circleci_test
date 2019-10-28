package main

import "fmt"

type AnimalInterface interface {
	bark()
}

type Dog struct {
	name string
}

type Cat struct {
	name string
}

func (d *Dog) bark() {
	fmt.Println(d.name + " barks ")
}

func (c *Cat) bark() {
	fmt.Println(c.name + " barks ")
}

func GetOnlyDog(animals []AnimalInterface) []Dog {
	var dogs []Dog
	for _, animal := range animals {
		d, ok := animal.(*Dog)
		if !ok {
			continue
		}
		dogs = append(dogs, *d)
	}
	return dogs
}

func main() {
	boxes := []AnimalInterface{
		&Dog{name:"poti"},
		&Cat{name:"mike"},
		&Dog{name:"taro"},
	}
	GetOnlyDog(boxes)
}