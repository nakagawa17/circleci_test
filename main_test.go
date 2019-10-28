package main

import (
	"testing"
	"github.com/stretchr/testify/assert"
)

func Test犬だけで絞り込む(t *testing.T) {
	boxes := []AnimalInterface{
		&Dog{name:"poti"},
		&Cat{name:"mike"},
		&Dog{name:"taro"},
	}
	results := GetOnlyDog(boxes)
	dogs := []Dog{
		Dog{name:"poti"},
		Dog{name:"taro"},
	}
	assert.Equal(t, results, dogs)
}
