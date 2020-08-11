void foo(const double* restrict in_a,
        const double* restrict in_b,
        double* restrict out)
{
    for (int i = 0; i < 1000; ++i) {
        double a = in_a[i];
        double b = in_b[i];
        for (int j = 0; j < 10000; ++j) {
            a = a + b;
        }
        out[i] = a;
    }
}
