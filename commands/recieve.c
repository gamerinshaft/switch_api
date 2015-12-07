#include <stdio.h>
#include <string.h>

int main(int argc, char *argv[]){
  char *path;
  char *fileName;
  if(argc >= 2){
   fileName = argv[1];
  }else{
    printf("Not select path!\n");
    return 0;
  }

  FILE *fp;

  fp = fopen(fileName, "w");
  fprintf(fp, "Test\n");
  fclose(fp);
  return 0;
}