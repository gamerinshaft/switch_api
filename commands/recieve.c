#include <stdio.h>
#include <string.h>

int main(int argc, char *argv[]){
  char *path;
  if(argc >= 2){
   path = argv[1];
  }else{
    printf("Not select path!\n");
    return 0;
  }

  FILE *fp;
  char *fileName = "irdata.txt";
  strcat(path, fileName);
  fp = fopen(path, "w");
  fprintf(fp, "Test\n");
  fclose(fp);
  return 0;
}