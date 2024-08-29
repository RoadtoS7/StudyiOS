#  Swift Modern Concurrency

## Task 
- Concurrency의 기본 단위. 비동기로 실행되는 코드 블럭.
- 종류 3가지
| Structured Concurrency | Unstructured Concurrency | Detached Concurrency 
| :---: | :---: | :---: |
| 부모 Task의 task-local value, actor isolation 상속 O | O | X | 
| 부모 Task 가 끝날 때, 자식 Task가 모두 완료되는 것이 보장된다. | X | X | 
    
