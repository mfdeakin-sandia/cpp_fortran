
program hello

  use iso_c_binding
  
  interface
     real(kind=c_double) function kahansum(v, l) bind(c)
       use iso_c_binding
       real (c_double) :: v(*)
       integer (c_int), VALUE :: l
     end function kahansum
  end interface

  integer (c_int) i, k, n
  parameter(k=40, n=100)
  real (c_double) vals(n), fsum, sum, diff
  fsum = 0.0
  do i = 1, k
     vals(i) = exp(dble(i))
     fsum = fsum + vals(i)
  end do
  do i = k + 1, n
     vals(i) = dble(i)
     fsum = fsum + vals(i)
  end do
  print *, "Calling kahansum"
  sum = kahansum(vals, n)
  diff = sum - fsum
  print *, sum
  print *, fsum
  print *, diff
end program hello
