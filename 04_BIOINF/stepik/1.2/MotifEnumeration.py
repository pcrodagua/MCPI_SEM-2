import itertools
from string import punctuation

def combination(k):
    return (''.join(p) for p in itertools.product('ATCG', repeat=k))

def hamming_distance(pattern, seq):
    return sum(c1 != c2 for c1, c2 in zip(pattern, seq))

def window(s, k):
    for i in range(1 + len(s) - k):
        yield s[i:i+k]

def motif_enumeration(k, d, DNA):
    pattern = set()
    for combo in combination(k):
        if all(any(hamming_distance(combo, pat) <= d 
                for pat in window(string, k)) for string in DNA):
            pattern.add(combo)
    return pattern

DNA = ['GACACACACGGCCGCCCTTATAGTG', 'AACTTGCGGCATACCTAATCTAGGC', 'GCCGCTCGCCGTCATGACGTCCGTC', 'AGTCTGAAAAGCTCCACCATGCAGC','CGGGGATGGCTATACCGCGAGCCGC','GCGAGGGGAGCTGAGGCTGCTGTCA']
print(" ".join(motif_enumeration(5, 1, DNA)))