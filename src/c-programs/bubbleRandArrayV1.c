/*
  This program sorts an array of elements using the bubble sort algorithm
  By: randerson112358
  
  Output:
  Enter total number(s) of elements: 4
  Enter the 4 elements: 1 5 4 3
  After Sorting: 1 3 4 5
  
*/

#include <stdio.h>
#include <stdlib.h>

int BubbleSort(int size, int *array);

int main(void){
	
	int size, i, array[20];
	
	printf("Enter total number(s) of elements: ");
	scanf("%d", &size);
	
	printf("Enter the %d elements: ", size);
	for(i=0; i<size; i++){
		scanf("%d", &array[i]);
	}
	
	//Run the Bubble Sort Algorithm to sort the list of elements
	BubbleSort(size, array);
	
	printf("After Sorting: ");
	for(i=0; i<size; i++){
		printf(" %d", array[i]);
	}
	
	printf("\n");
	// system("pause"); // comment this line if you are not using Windows OS
	return 0; 
}

int BubbleSort(int size, int *array){
	
	int i, j, temp;
	
	//Bubble sorting algorthm
	for(i=size-2; i>= 0; i--){
		for(j=0; j<=i; j++){
			
			//Swap
			if(array[j] > array[j+1]){
				temp = array[j];
				array[j] = array[j+1];
				array[j+1]= temp;
			}
		}
	}
	
	return 1;
}
