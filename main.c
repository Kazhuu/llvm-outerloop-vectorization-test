const int work_group_size = 1000;

void foo1(const double* restrict in_a,
        const double* restrict in_b,
        double* restrict out)
{
    #pragma clang loop vectorize(enable)
    for (int i = 0; i < work_group_size; ++i) {
        double a = in_a[i];
        double b = in_b[i];
        for (int j = 0; j < 10000; ++j) {
            a = a + b;
        }
        out[i] = a;
    }
}
