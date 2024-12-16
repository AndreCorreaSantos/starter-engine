
```bash
g++ -g parser.cpp -o parser
valgrind --tool=callgrind ./parser ../onnx.txt
callgrind_annotate callgrind.out.<pid>
kcachegrind callgrind.out.<pid>
```