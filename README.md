# Octave parallel package example

## Description

The repository showcase parallel package usage and limitation.

## Getting Started

1. Install [octave](https://octave.org/download) on your machine
2. Clone the repository 


### Dependencies

* Struct
```
pkg install -forge struct
```
* Parallel
```
pkg install -forge parallel
```


### Executing program


* Within the cloned folder, run the following command line in your shell :
```
octave pararrayfun_script
```

### Output

You should get following output :
```
>> pararrayfun_script
---- 'arrayfun @add' ----
{
  [1,1] = Sequential calculation time :
  [1,2] = 0.058801
}
---- 'pararrayfun @add' ----
{
  [1,1] = Parallel calculation time :
  [1,2] = 2.1209
}
---- 'arrayfun @myfun' ----
{
  [1,1] = Sequential calculation time :
  [1,2] = 11.295
}
---- 'pararrayfun @myfun' ----
{
  [1,1] = Parallel calculation time :
  [1,2] = 3.7105
}
```

## Authors

* [@fofolevrai](https://github.com/fofolevrai)



## License

This project is provided under the [BSD-3](https://opensource.org/license/bsd-3-clause) License - see the [LICENCE.md](LICENCE.md) file for details

