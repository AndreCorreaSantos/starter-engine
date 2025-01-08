#include <stdio.h>
#include <stdlib.h>



// ---------------------------------------- TENSOR DEFINITIONS ------------------------------------------------
typedef struct{
    int rank;
    int* shape;
    float* data; // flattened data
} Tensor;


Tensor* create_T(int rank,int* shape,float* data){
    Tensor* tensor = (Tensor*)malloc(sizeof(Tensor));
    tensor->rank = rank;
    tensor->shape = (int*)malloc(rank * sizeof(int));

    for(int i = 0; i < rank; i++){
        tensor->shape[i] = shape[i];
    }

    int flat_size = 1;
    for (int i=0;i < rank; i++){
        flat_size *= shape[i];
    }
    tensor->data = (float*)malloc(flat_size*sizeof(float));

    for (int i = 0; i<flat_size; i++){
        tensor->data[i] = data[i];
    }

    return tensor;
}   
void print_tensor(Tensor* tensor){

    int flat_size = 1;
    for (int i = 0; i< tensor->rank; i++){
        flat_size *= tensor->shape[i];
    }
    for (int i =0; i<flat_size; i++){
        printf("%f",tensor->data[i]);
        printf("\n");
    }
}   

// --------------------------------------------- CACHE DEFINITIONS ------------------------------------------------------------

#define MAX_SIZE                                           
    100 // Maximum number of elements in the map 
  
int size = 0; // Current number of elements in the map 
char keys[MAX_SIZE][100]; // Array to store the keys 
int values[MAX_SIZE]; // Array to store the values 


struct typedef{
    char
}

  
// Function to get the index of a key in the keys array 
int getIndex(char key[]) 
{ 
    for (int i = 0; i < size; i++) { 
        if (strcmp(keys[i], key) == 0) { 
            return i; 
        } 
    } 
    return -1; 
} 
  
void insert(char key[], int value) 
{ 
    int index = getIndex(key); 
    if (index == -1) { 
        strcpy(keys[size], key); 
        values[size] = value; 
        size++; 
    } 
    else { // Key found 
        values[index] = value; 
    } 
} 
  
// Function to get the value of a key in the map 
int get(char key[]) 
{ 
    int index = getIndex(key); 
    if (index == -1) { 
        return -1; 
    } 

    return values[index]; 
} 




int main(void) {
    int rank = 2;
    
    int shape[] = {2, 3}; // Use curly braces to initialize an array
    float data[] = {0.0, 1.0, 2.0, 3.0, 4.0, 5.0}; // Use curly braces
    Tensor* tensor = create_T(rank,shape,data);
    print_tensor(tensor);



    return 0;
}
