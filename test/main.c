#include <stdio.h>
#include <stdlib.h>
#include <time.h>

static const int iterations = 400;
static const int work_group_size = 1000;

// External functions added during linking from function.c and
// function_vectorize.c files.

// Not vectorized version.
extern void foo(const double* restrict in_a,
        const double* restrict in_b,
        double* restrict out);
// Vectorized using LLVM VPlan (vectorization plan) outer loop vectorization.
extern void foo_vectorize(const double* restrict in_a,
        const double* restrict in_b,
        double* restrict out);

void init(double* a, double* b, double* c) {
    for(int i = 0; i < work_group_size; ++i) {
        c[0] = 0.0;
    }
    double a_begin = 0.6743987;
    double b_begin = 0.9999999;
    double increment = 0.000001;
    for (int i = 0; i < work_group_size; ++i) {
        a[i] = a_begin;
        a_begin = a_begin + increment;
        b[i] = b_begin;
        b_begin = b_begin + increment;
    }
}

int main() {
    clock_t begin;
    clock_t end;
    double a[work_group_size];
    double b[work_group_size];
    double c1[work_group_size];
    double c2[work_group_size];
    init(a, b, c1);
    init(a, b, c2);

    begin = clock();
    for (int i = 0; i < iterations; ++i) {
        foo(a, b, c1);
    }
    end = clock();
    double foo_time = (double)(end - begin) / CLOCKS_PER_SEC;
    printf("foo: %f\n", foo_time);
    begin = clock();
    for (int i = 0; i < iterations; ++i) {
        foo_vectorize(a, b, c2);
    }
    end = clock();
    double foo_vectorize_time = (double)(end - begin) / CLOCKS_PER_SEC;
    printf("foo_vectorize: %f\n", foo_vectorize_time);
    printf("%.2f%% faster\n", (foo_time - foo_vectorize_time) / foo_time * 100);

    for(int i = 0; i < work_group_size; ++i) {
        if (c1[i] != c2[i]) {
            printf("%f != %f", c1[i], c2[i]);
            exit(1);
        }
    }
    printf("arrays are equal\n");
    return 0;
}
