
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
