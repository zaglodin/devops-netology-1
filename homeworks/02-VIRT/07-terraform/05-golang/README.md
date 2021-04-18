# Homework 7.5

1. done

2. done

3.
   1. Код:

      ```go
      package main

      import "fmt"

      const foot = 0.3048

      func convert(x float64) float64 {
         return x / foot
      }

      func main() {
         fmt.Println(convert(42))
      }
      ```

   2. Код:

      ```go
      package main

      import "fmt"

      func main() {
         x := []int{48,96,86,68,57,82,63,70,37,34,83,27,19,97,9,17,}
         min := x[0]
         for _, v := range x {
            if (v < min) {
                  min = v
            }
         }
         fmt.Println(min)
      }
      ```

   3. Код:

      ```go
      package main

      import "fmt"

      func main() {
         for i := 3; i < 100; i += 3 {
            fmt.Println(i)
         }
      }
      ```
