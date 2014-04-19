# bench some web microframeworks (Ruby)

Because we don't have enough drama, let's bench some *hello world* apps!

## Why?

As part of some research, collected some benchmark around Ruby web
microframeworks.

The idea is bench the performance from [Rack](https://github.com/rack/rack),
throught the stack of the framework to the minimum representation of an
application (*Hello World* apps).

It is not the goal to bechmark hits to the database or external services,
nor to do a silly *fibonacci-as-a-service*, ok?

## What?

The following microframeworks were considered when doing this research:

- [Brooklyn](https://github.com/luislavena/brooklyn) - [brooklyn.ru](apps/brooklyn.ru)
- [Cuba](https://github.com/soveran/cuba) - [cuba.ru](apps/cuba.ru)
- [Hobbit](https://github.com/patriciomacadden/hobbit) - [hobbit.ru](apps/hobbit.ru)
- [Lotus (Router)](https://github.com/lotus/router) - [lotus-router.ru](apps/lotus-router.ru)
- [Nancy](https://github.com/heapsource/nancy) - [nancy.ru](apps/nancy.ru)
- [NYNY](https://github.com/alisnic/nyny) - [nyny.ru](apps/nyny.ru)
- [Mustermann](https://github.com/rkh/mustermann) - [mustermann.ru](apps/mustermann.ru)
- [Rack](https://github.com/rack/rack) - [rack.ru](apps/rack.ru) + [rack-response.ru](apps/rack-response.ru)
- ~~[Rails](https://github.com/rails/rails) - [rails.ru](apps/rails.ru)~~
- [Ramaze](https://github.com/Ramaze/ramaze) - [ramaze.ru](apps/ramaze.ru)
- [Rambutan](https://github.com/NewRosies/rambutan) - [rambutan.ru](apps/rambutan.ru)
- [Scorched](https://github.com/Wardrop/Scorched) - [scorched.ru](apps/scorched.ru)
- [Sinatra](https://github.com/sinatra/sinatra) - [sinatra.ru](apps/sinatra.ru)

Please note that while Rails has been added to the list, it is just a
minimalistic representation (using Metal, no full middleware stack, etc). You
shouldn't take the performance numbers mentioned here about Rails (or any
other) as scientific and decision-taking references.

## How?

Used [wrk](https://github.com/wg/wrk) to benchmark, locally, a burst of
requests (in 2 threads) over 10 seconds. The command line used was:

```console
$ wrk -t 2 http://localhost:9292/
```

All the frameworks were run using [Puma](https://github.com/puma/puma) on
Ruby 2.1, in production mode and using 16 threads:

```console
$ puma -e production -t 16:16 <framework.ru>
```

## Run benchmark for all frameworks

```console
# use `bundle exec`, if needed
$ bench/summary-memory
$ bench/summary-speed
```

### Have some numbers around?

Yup, I do:

#### Requests/sec
<!-- speed_table -->
```
Framework            Requests/sec  % from best
----------------------------------------------
rack                      8808.74       100.0%
mustermann                7673.94       87.12%
cuba                      7550.91       85.72%
hobbit                    7447.90       84.55%
lotus-router              7346.17        83.4%
rack-response             6847.69       77.74%
brooklyn                  6513.61       73.94%
rambutan                  5991.08       68.01%
nancy                     5762.34       65.42%
nyny                      4111.48       46.68%
sinatra                   2879.52       32.69%
scorched                  1654.10       18.78%
ramaze                    1341.83       15.23%
```
<!-- speed_table_end -->

#### Memory Allocation/Request
<!-- mem_table -->
```
Framework       Allocs/Req Memsize/Req
--------------------------------------
rack                    56        1704
hobbit                  70        1976
mustermann              71        2040
cuba                    72        1936
rack-response           79        3072
lotus-router            91        2080
brooklyn                98        2432
nancy                  107        3440
rambutan               114        3448
nyny                   173        5248
sinatra                253       10011
ramaze                 575       23797
scorched              1708      115524
```
<!-- mem_table_end -->


These numbers were collected on:

- OSX, 10.8.5, MacBook Pro i5 (2.5GHz), 8GB 1600 MHz DDR3.
- ruby 2.1.1p76 (GCC 4.7.3)
