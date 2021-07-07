# Creating gradients in GraphicSVG

With GraphicSVG 7.2.0, you can fill shapes with gradients. The two kinds of gradients can be created: linear and radial.

## Linear gradients

A gradient is a series of colours that fade into each other. The colours their positions are called stops.

Let's create a square!

```elm
square 20
  |> filled red
```

![image](https://user-images.githubusercontent.com/12722104/124660980-e9803c00-de74-11eb-98cc-224ef6a022ee.png)

### Your first gradient

That square was filled red. Pretty boring! Instead, lets make the circle with a linear gradient!

```elm
square 20
  |> filled 
    (gradient
      [
        stop 5 red
      ]
    )
```

![image](https://user-images.githubusercontent.com/12722104/124661095-0f0d4580-de75-11eb-9811-bd2af22dd2f7.png)

### A better (actual) gradient!

Not much has changed!! That's because we only have one stop, so the whole square is just red! Let's try adding another stop.

```elm
square 20
  |> filled 
    (gradient
      [
        stop red 5
      , stop orange 10
      ]
    )
```

![image](https://user-images.githubusercontent.com/12722104/124661313-5693d180-de75-11eb-8853-99808f1e16ca.png)

Now we're getting somewhere! Now, at a position of x=5, we have red, and at a position of x=10, we have orange, and between them is a nice fade
from one to the other.

### Something looks funny?

Something might look weird. Why is does x=5 appear to be in the centre of the shape? The way the gradients are defined is that they are centred
about the centre of the shape by default. And they are as wide as the last stop. So, in this case, the gradient has a width of 10, centred about
the centre of the shape. If we add a blue stop at 0, and a few indicators this should make more sense. This is the code


```elm
square 20
  |> filled 
    (gradient
        [
            stop blue 0
        ,   stop red 5
        ,   stop orange 10
        ]
    )
```

And here is an annotated version of the gradient:

![image](https://user-images.githubusercontent.com/12722104/124777655-5eec1b00-df0e-11eb-99eb-437cc90ac9f8.png)

### Rotating linear gradients

To rotate the gradients, you can use the `rotateGradient` function. This must be applied to the gradient itself:

```elm
square 20
  |> filled 
    (gradient
        [
            stop blue 0
        ,   stop red 5
        ,   stop orange 10
        ]
        |> rotateGradient (degrees 45)
    )
```

![image](https://user-images.githubusercontent.com/12722104/124778189-cace8380-df0e-11eb-8b91-a9dd87f9d38a.png)

The gradient is rotated in the same way that a shape would be. All the relative positions of the stops are the same, just in a rotated frame
of reference. You can, of course, animate this too.

## Radial gradients

Radial gradients work in much the same way as linear gradients, except that a stop at 0 now represents the centre of the gradient and the
last stop is the outer radius of the gradient. Any code you've written for a linear gradient can be easily transformed into a radial
gradient and vice versa, just by changing the name of the function. For example, this is a simple change to the linear gradient above:

```elm
square 20
  |> filled 
    (radialGradient
        [
            stop blue 0
        ,   stop red 5
        ,   stop orange 10
        ]
        |> rotateGradient (degrees 45)
    )
```

Which produces:

![image](https://user-images.githubusercontent.com/12722104/124779062-7972c400-df0f-11eb-8c95-462d481c5a0a.png)


## Transparent stops

One of perhaps the more powerful ways to use gradients is to use (semi) transparent stops for interesting shadow effects. For this, you can use
the `transparentStop` function inside your list of stops. For instance, let's say we want to make a sun with rays coming out of it. Let's
make a radial gradient with solid yellow at position 25, and a fully transparent yellow at position 50.

```elm
circle 50
  |> filled
      (
          radialGradient
          [
            stop yellow 25
          , transparentStop yellow 50 0 -- yellow at position 50 with 0 opacity
          ]
      )
```

This will result in a neat glowing effect for our sun:

![image](https://user-images.githubusercontent.com/12722104/124780267-762c0800-df10-11eb-915b-039d7b261776.png)

Of course, transparent stops can be used with both linear and radial gradients.

## That's all for now!

Enjoy the new gradients! We're excited to see what you can come up with using it!
