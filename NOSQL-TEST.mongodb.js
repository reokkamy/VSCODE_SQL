db.createCollection('logs2', { capped: true, size: 5000 })


for (let i = 2000; i < 3000; i++) {
    db.logs2.insertOne({
        message: `로그 메시지 ${i}`,
        timestamp: new Date(),
    })
}

db.logs2.find()





db.users.insertOne({
    name: '김무진',
    birth: '1983-06-06',
    favoriteFood: ['소고기', '대게'],
    regdate: new Date(),
})
db.users.insertOne({
    name: '김무진1',
    birth: '1983-01-02',
    favoriteFood: ['삼겹살', '계란'],
    regdate: new Date(),
})
db.users.insertOne({
    name: '유영준',
    birth: '1983-06-06',
    favoriteFood: ['빵', '치킨'],
    regdate: new Date(),
})








db.users.deleteOne({ name: '김무진2' })





db.users.find()




