
subroutine sumpair (a, b) bind(c)
  use iso_c_binding
  real(c_double), intent(inout) :: a
  real(c_double), intent(in) :: b
  a = a + b
end subroutine sumpair

program hello

  use iso_c_binding
  
  interface
     real(kind=c_double) function kahansum(v, l) bind(c)
       use iso_c_binding
       real (c_double) :: v(*)
       integer (c_int), value :: l
     end function kahansum

     real(kind=c_double) function binarysum(v, l) bind(c)
       use iso_c_binding
       real (c_double) :: v(*)
       integer (c_int), value :: l
     end function binarysum

     subroutine sumpair(a, b) bind(c)
       use iso_c_binding
       real (c_double), intent(inout) :: a
       real (c_double), intent(in) :: b
     end subroutine sumpair
  end interface

  integer (c_int) i, k, n
  parameter(k=100, n=400000)
  real (c_double) vals(n), fsum, ksum, diff
  fsum = 0.0
  do i = 1, k
     vals(i) = exp(dble(i))
     fsum = fsum + vals(i)
  end do
  do i = k + 1, n
     vals(i) = dble(i) / 2047.999511719
     fsum = fsum + vals(i)
  end do
  print *, "Calling kahansum"
  ksum = kahansum(vals, n)
  diff = ksum
  call sumpair(diff, -fsum)
  print *, "Calling binarysum"
  bsum = binarysum(vals, n)
  print *, ksum
  print *, fsum
  print *, bsum
  print *, diff
end program hello
