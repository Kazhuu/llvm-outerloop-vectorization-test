#define DATA_TYPE float

extern double sqrt(double);

void gramschmidt_kernel1(DATA_TYPE *a, DATA_TYPE *r, DATA_TYPE *q, int k)
{
    int ni = 512;
    int nj = 512;
    #pragma clang loop vectorize(assume_safety) vectorize_width(8)
    for (int tid = 0; tid < 512; ++tid) {
        if (tid == 0)
        {
            DATA_TYPE nrm = 0.0;
            int i;
            for (i = 0; i < ni; i++)
            {
                nrm += a[i * nj + k] * a[i * nj + k];
            }
            /*r[k * nj + k] = sqrt(nrm);*/
        }
    }
}
