# Activity 5.2 Parallel and Concurrent Programming
this is the user manual for the prime number's summattion program! Using secuencial or parallel process.

![image](https://github.com/carlosfragoso21/TC2037_AP/assets/80837879/478b539d-e24f-4ae3-adb0-1a19bdb7a401)

## Big O complex


The process of determining whether a number is prime or not, within the summatory process, has a complexity of O(n * sqrt(n)). The complexity of the function depends on the limit provided, but this limit is reduced when the prime? function validates if sqrt(n) is less than "i". The prime? function itself has a complexity of O(sqrt(n)), while the function that calls prime? has a linear complexity of O(n).

Combining these complexity results, we can infer that the overall complexity of the algorithm is: O(n * sqrt(n)).

Additionally, when parallelism is employed, the complexity remains the same. However, by utilizing multiple processors or cores, the computation can be distributed, potentially reducing the overall execution time.

## Time comparation

![image](https://github.com/carlosfragoso21/TC2037_AP/assets/80837879/6fe13450-61e9-4dc9-b2e5-9bf23f04aae3)

We get the same result in the summation

But we can see diference between the time that needs to generate result in a sequencial proccess and a parallel process
The cores that the parallel instructions is handle is 12. So in a sequencial process time is 10.8 seconds and in a parallel one time is 1.6 seconds
with this information we can know that speed up is 6.218499507262522 seconds.

## User Manual

Module Name: Hw.Prime

This module provides four functions that can be called by the user:

sum_primes/1: This function calculates the sum of prime numbers up to the specified limit using a sequential process.

sum_primes_parallel/2: This function calculates the sum of prime numbers up to the specified limit using a parallel process. The arguments for this function are the limit and the number of cores or processes to utilize in parallel.

calc_speedup/2: This function calculates the speedup achieved by comparing the execution time of the sequential and parallel processes for a given limit and number of cores/processes.

calc_speedup/0: This function calculates the speedup achieved by comparing the execution time of the sequential and parallel processes for a predefined limit constant (5000000) and determines the number of cores available on your machine.

Steps:

1.- Download exs file

2.- test the public function that you want in order to compare results, time resuts depending in process(sequencial or parallel)





