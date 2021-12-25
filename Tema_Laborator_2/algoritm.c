#include <stdio.h>
#define MAXN 30

int init[105];
int perm[105];
int f[35];
int n, m;

void back(int curr) {
	int i, j, elem, ok;

	if(curr > 3 * n) {
		return;
	}
	else {
		if(perm[curr] == 0) {
			i = 1;
			elem = 0;
			while(i <= n && elem == 0) {
				if(f[i] < 3) {
					ok = 1;
					for(j = 1; j <= m && curr - j > 0; j++)
						if(perm[curr - j] == i)
							ok = 0;
					for(j = 1; j <= m && curr + j <= 3 * n; j++)
						if(perm[curr + j] == i)
							ok = 0;
					if(ok)
						elem = i;
				}
				i++;
			}
			if(elem != 0) {
				f[elem]++;
				perm[curr] = elem;
				back(curr + 1);
			}
			else {
				f[perm[curr]]--;
				perm[curr] = 0;
				curr--;
				while(curr > 0 && init[curr] != 0)
					curr--;
				back(curr);
			}
		}
		else if(init[curr] != 0) {
			back(curr + 1);
		}
		else {
		    i = perm[curr] + 1;
		    f[perm[curr]]--;
		    perm[curr] = 0;
			elem = 0;
			while(i <= n && elem == 0) {
				if(f[i] < 3) {
					ok = 1;
					for(j = 1; j <= m && curr - j > 0; j++)
						if(perm[curr - j] == i)
							ok = 0;
					for(j = 1; j <= m && curr + j <= 3 * n; j++)
						if(perm[curr + j] == i)
							ok = 0;
					if(ok)
						elem = i;
				}
				i++;
			}
			if(elem != 0) {
				f[elem]++;
				perm[curr] = elem;
				back(curr + 1);
			}
			else {
				f[perm[curr]]--;
				perm[curr] = 0;
				curr--;
				while(curr > 0 && init[curr] != 0)
					curr--;
				back(curr);
			}
		}
	}
}

int main() {
	int i, j, ok;

	scanf("%d%d", &n, &m);
	for(i = 1; i <= 3 * n; i++) {
		scanf("%d", &init[i]);
		f[init[i]]++;
		perm[i] = init[i];
	}
	back(1);

	ok = 1;
	for(i = m + 1; i <= 3 * n - m; i++) {
		for(j = 1; j <= m; j++)
			if(perm[i] == perm[i - j] || perm[i] == perm[i + j])
				ok = 0;
	}

	if(ok == 1) {
		for(i = 1; i <= 3 * n; i++)
			printf("%d ", perm[i]);
		printf("\n");
	}
	else
		printf("-1\n");
	return 0;
}