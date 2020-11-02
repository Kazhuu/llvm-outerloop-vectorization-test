#define DATA_TYPE float

void mm2_kernel1(DATA_TYPE *tmp, DATA_TYPE *A, DATA_TYPE *B, int ni, int nj, int nk, int nl, DATA_TYPE alpha, DATA_TYPE beta)
{
    for (int i = 0; i < 1024; ++i) {
        // assume_safety adds parallel metadata to load/store instructions.
        #pragma clang loop vectorize(assume_safety) vectorize_width(8)
        for (int j = 0; i < 1024; ++i) {
            if ((i < 1024) && (j < 1024))
            {
                tmp[i * nj + j] = 0;
                int k;
                for (k = 0; k < 1024; k++)
                {
                    tmp[i * nj + j] += alpha * A[i * nk + k] * B[k * nj + j];
                }
            }
        }
    }
}
