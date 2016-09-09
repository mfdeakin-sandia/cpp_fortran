
#include <stdio.h>

double kahansum(double *inputs, int len) {
  if(len == 0) {
    return 0.0;
  }
  double sum = inputs[0];
  double alignment_err = 0.0;
  int i;
  for(i = 1; i < len; i++) {
    double tmp1 = inputs[i] - alignment_err;
    double tmp2 = sum + tmp1;
    alignment_err = (tmp2 - sum) - tmp1;
    sum = tmp2;
  }
  return sum;
}

extern void sumpair(double *a, const double *b);

double binarysum(double *inputs, int len) {
  int center = len / 2,
    extra = len % 2,
    i;
  if(center > 0) {
    #pragma omp parallel for
    for(i = 0; i < center; i++) {
      sumpair(&inputs[i], &inputs[i + center]);
    }
    double sum = binarysum(inputs, center);
    if(extra) {
      sum += inputs[len - 1];
    }
    return sum;
  }
  else {
    if(extra) {
      return inputs[0];
    }
    else {
      return 0.0;
    }
  }
}
