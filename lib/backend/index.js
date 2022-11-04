const mongoose = require('mongoose');
const express = require('express');
const { quizzes } = require('./database/quiz_data.js');
const app = express();

app.use(express.json());

mongoose.connect('mongodb://localhost/quiz-management')
    .then(() => console.log('Connected to MongoDB...'))
    .catch(err => console.error('Could not connect', err));

const quizSchema = new mongoose.Schema({
    batch: Number,
    branch: String,
    quizName: String,
    numberOfQuestions: Number,
    listOfQuestions: [
        {}
    ]
});

const Quiz = mongoose.model('Quiz', quizSchema);

async function createQuiz(quiz){

    const q = new Quiz({
        name: quiz.name,
        author: quiz.author,
        tags: quiz.tags,
        isPublished: quiz.isPublished,
    });

    const result = await q.save();
    console.log(result);
}




//to get all the quiz available
app.get('/quizzes', (req, res) => {
    if(quizzes == null) return res.status(400).send("No Quiz available now");
    res.send(quizzes);
});

//should happen after the student login
app.get('/quizzes/:batch/:branch', (req, res) => {
    const q = quizzes.find(test => test.batch === req.params.batch && test.branch == req.params.branch);
    if(q == null){
        return res.status(400).send("No Quiz available now");
    }
    res.send(q);
});

//quiz id and the array of options selected 
app.post('/quiz-validation', (req, res) => {
    const currentQuiz = quizzes.find(test => test.quizid === req.body.quizid);
    console.log(currentQuiz.listOfQuestions[0].correctOptionIndex);
    let totalScore = 0, j = 0;
    
    for(let i = 0; i < currentQuiz.listOfQuestions.length; i++){
        if(currentQuiz.listOfQuestions[i].correctOptionIndex === req.body.listOfAnsweredOptions[i]){
            totalScore++;
        }
    }
    res.send({ "totalScore": totalScore});
});

//create quiz -  faculty login
app.post('/quizzes', (req, res) => {
    const quiz = req.body;
    createQuiz(quiz);
    console.log("Reached post call....");
    res.send(quiz);
});


const port = process.env.PORT || 3000;
app.listen(port, () => console.log(`Listening on port ${port}....`));