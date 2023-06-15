
defmodule Hw.Primes do

  defp prime?(n) when n < 2, do: false
  defp prime?(n), do: do_prime(2,n,trunc(n**0.5))
  defp do_prime(i, n, rn)do
    cond do
      i > rn ->
        true
      rem(n,i) == 0 ->
        false
      true ->
        do_prime(i+1,n,rn)
    end
  end

  def sum_primes(limit), do: do_sum_primes({0,limit})
  defp do_sum_primes({i,limit}) do
    cond do
      limit + 1 == i ->
        0
      prime?(i) == true ->
        i + do_sum_primes({i + 1,limit})
      prime?(i) == false ->
        do_sum_primes({i + 1, limit})
    end
  end


  defp make_ranges(start, add, cores, remainder) do
    cond do
      cores == 1 ->
        [{start + 1, start + add + remainder}]
      true ->
        [{start + 1, start + add} | make_ranges(start + add, add, cores - 1, remainder)]
    end
  end

  def sum_primes_parallel(limit, cores) do
    make_ranges(0,div(limit,cores),cores, rem(limit,cores))
    |> Enum.map(&Task.async(fn -> do_sum_primes(&1) end))
    |> Enum.map(&Task.await(&1, :infinity))
    |> Enum.sum()
  end

  def calc_speedup(limit,cores)do
    (:timer.tc(fn -> Hw.Primes.sum_primes(limit) end) |> elem(0) |> Kernel./(1_000_000)) /
    (:timer.tc(fn -> Hw.Primes.sum_primes_parallel(limit,cores) end) |> elem(0) |> Kernel./(1_000_000))
  end
  def calc_speedup()do
    (:timer.tc(fn -> Hw.Primes.sum_primes(5000000) end) |> elem(0) |> Kernel./(1_000_000)) /
    (:timer.tc(fn -> Hw.Primes.sum_primes_parallel(5000000,System.schedulers_online()) end) |> elem(0) |> Kernel./(1_000_000))
  end

end
