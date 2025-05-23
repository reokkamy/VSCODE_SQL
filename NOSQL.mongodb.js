use('test')//기본 데이터 베이스, test 사용함. 생략시 기본test데이터베이스 사용

//테이블 생성후 데이터 추가하는 기본문법:insertOne

//db.[테이블명].insertOne({
//   [컬럼명]:[값],
//    name:'홍길동',
//    age:20
//   favorite: ['apple', 'banana'], })

//한줄 실행: ctrl+alt+s
//전체실행 : ctrl+alt+r
db.user.insertOne({
    name: '홍길동',
    age: 20,
    favorite: ['apple', 'banana'],
})

//조회
//db.[테이블명].find({조건})
db.user.find();

//수정 
// db.[테이블명].updateOne({조건}, {수정할 값})
db.users.updateOne(
    { name: '홍길동' }, // 조건
    { $set: { age: 30 } } // 수정할 값
)

// 삭제
// db.[테이블명].deleteOne({조건})  
db.users.deleteOne({ name: '홍길동' }) // 조건에 맞는 첫 번째 문서 삭제


//capped collection, 컬렉션=테이블
//컬렉션이 용량 초과하게되면, 오래된 데이터부터 차례대로 삭제하는 기능
// db.createCollection('컬렉션명', { capped: true, size: 용량 })
//용량이 5kb인 컬렉션 생성, 부가 기능으로 용량초과시 오래된 데이터부터 삭제
db.createCollection('logs', { capped: true, size: 5000 }) //5kb
//샘플데이터 추가 , 반복문을 이요해서 샘플로 1000개 추가
for (let i = 2000; i < 3000; i++) {
    db.logs.insertOne({
        message: `로그 메시지 ${i}`,
        timestamp: new Date(),//오라클에서 sysdate와 같은 기능
    })
}
db.logs.find() //컬렉션에 있는 모든 데이터 조회

db.createCollection('logs2', { capped: true, size: 5000 })

for (let i = 1000; i < 2000; i++) {
    db.logs2.insertOne({
        message: `로그 메시지 ${i}`,
        timestamp: new Date(),//오라클에서 sysdate와 같은 기능
    })
}

//퀴즈1
//한개 문서 삽입, 컬렉션 명: users2
//이름 , 생년월일, 좋아하는 음식, 등록날짜 등
db.users2.insertOne({
    name: '김무진',//이름 문자열로 저장
    birth: '1983-06-06', //생년월일 문자열로 저장
    favoriteFood: ['안창살', '대게'], //좋아하는 음식 배열로 저장
    regdate: new Date(),//현재날짜 , 타입 date로 저장
})

db.users2.find() //컬렉션에 있는 모든 데이터 조회




//퀴즈2
//컬렉션 명: users2, 수정해보기
//항목들 중, 수정2 문자열 추가해보기
db.users2.updateOne(
    { name: '김무진 이름1' }, // 조건
    { $set: { name: '김무진으로 다시', favoriteFood: ['삼겹살', '소고기'] } }
)



//퀴즈3
//users2에서 등록한 항목 삭제해보기
db.users2.deleteOne({ name: '김무진으로 다시' }) // 조건에 맞는 첫 번째 문서 삭제