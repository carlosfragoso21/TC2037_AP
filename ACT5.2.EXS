#*----------------------------------------------------*
#*  Activity 5.2 Parallel and Concurrent Programming  *
#*----------------------------------------------------*
#*         Creator    | Version |    Date             *
#*----------------------------------------------------*
#*                                                    *
#*     Carlos Fragoso |   1.0   |  14/06/2023         *
#*                                                    *
#* Modifications: Creation of exs, Module             *
#* Function Hw.Primes.                                *
#* Also Functions: prime?, do_prime, sum_primes,      *
#* do_sum_primes, make ranges,sum_primes_parallel,    *
#* calc_speedup/2, calc_speedup/0                     *
#*----------------------------------------------------*

defmodule Hw.Primes do #main module

  defp prime?(n) when n < 2, do: false #function used to call do_prime
  defp prime?(n), do: do_prime(2,n,trunc(n**0.5))
  defp do_prime(i, n, rn)do #gives i, n and sqrt(n) to avoid the calculation of sqrt in every recursive iteration
    cond do
      i > rn ->
        true
      rem(n,i) == 0 ->
        false
      true ->
        do_prime(i+1,n,rn) #recursive call adding plus 1 to i
    end
  end

  def sum_primes(limit), do: do_sum_primes({0,limit}) # function used to call do_sum_primes
  defp do_sum_primes({i,limit}) do # Summatory functionality validating prime or not in current number
    cond do
      limit + 1 == i ->
        0 #exceed of limit, so 0 to summatory and the stop of recursive iterarions
      prime?(i) == true ->
        i + do_sum_primes({i + 1,limit}) #prime case, summmatory of i
      prime?(i) == false ->
        do_sum_primes({i + 1, limit}) #not prime, just recursive call
    end
  end


  defp make_ranges(start, add, cores, remainder) do #Function that creates a list of duplas
    cond do
      cores == 1 ->
        [{start + 1, start + add + remainder}] #last core must stop recursive iteration and add remainder to last component of dupla
      true ->
        [{start + 1, start + add} | make_ranges(start + add, add, cores - 1, remainder)] #Generate current dupla and recursive call to complete rest of duplas
    end
  end

  def sum_primes_parallel(limit, cores) do #summmatory of primes with parallel process
    make_ranges(0,div(limit,cores),cores, rem(limit,cores)) #make ranges considering cores quantity
    |> Enum.map(&Task.async(fn -> do_sum_primes(&1) end)) #map to call do_sum_primes with every generated range (in async tasks)
    |> Enum.map(&Task.await(&1, :infinity)) # to wait result from all async tasks
    |> Enum.sum() #summatory of all the results from async tasks
  end

  #Next functions are speedup calculation (sequencial time / parallel time)
  #Also instruction :timer.tc is used to get time, |> elem(0) |> Kernel./(1_000_000)) is added to convert result to seconds
  def calc_speedup(limit,cores)do
    (:timer.tc(fn -> Hw.Primes.sum_primes(limit) end) |> elem(0) |> Kernel./(1_000_000)) /
    (:timer.tc(fn -> Hw.Primes.sum_primes_parallel(limit,cores) end) |> elem(0) |> Kernel./(1_000_000))
  end
  def calc_speedup()do
    (:timer.tc(fn -> Hw.Primes.sum_primes(5000000) end) |> elem(0) |> Kernel./(1_000_000)) /
    (:timer.tc(fn -> Hw.Primes.sum_primes_parallel(5000000,System.schedulers_online() ) end) |> elem(0) |> Kernel./(1_000_000))
  end

end
