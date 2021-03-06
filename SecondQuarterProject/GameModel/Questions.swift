//
//  Questions.swift
//  SecondQuarterProject
//
//  Created by Anton Scherbaev on 24.02.2021.
//

import Foundation

struct Question: Codable {
    let question: String
    var whriteAnswer: String
    var answers: [String]
}

// Источник вопросов https://1gai.ru/baza-znaniy/526308-50-interesnyh-voprosov-dlja-detej.html

var questions: [Question] = []

let defaultQuestionsBase: [Question] = [
    Question(question: "Какое сухопутное животное может открыть рот максимально широко?", whriteAnswer: "Бегемот", answers: ["Бегемот", "Бабуин", "Крокодил", "Аллигатор"]),
    Question(question: "Какое животное самое крупное на Земле?", whriteAnswer: "Синий кит", answers: ["Гигантский кальмар", "Синий кит", "Кашалот", "Африканский слон"]),
    Question(question: "Какое млекопитающее умеет летать?", whriteAnswer: "Летучая мышь", answers: ["Колуго", "Белоголовый орлан", "Летучая мышь", "Белка-летяга"]),
    Question(question: "Как называется животное, которое употребляет в пищу растения и мясо?", whriteAnswer: "Всеядное животное", answers: ["Плотоядное животное", "Травоядное животное", "Пескатариан", "Всеядное животное"]),
    Question(question: "Почему каланы («морские выдры») держатся за руки?", whriteAnswer: "Чтобы они не уплывали, когда спят", answers: ["Чтобы они не уплывали, когда спят", "Потому что они любят друг друга", "Чтобы показать, что они в одной семье", "Потому что они играют"]),
    Question(question: "Как отличить насекомое от паука?", whriteAnswer: "Все вышеперечисленные факты", answers: ["У насекомых три части тела, у пауков – две", "Все вышеперечисленные факты", "У насекомых шесть ног, у пауков – восемь", "У насекомых могут быть крылья, у пауков они отсутствуют"]),
    Question(question: "Чем утконос отличается от других млекопитающих?", whriteAnswer: "Откладывает яйца", answers: ["Крякает, как утка", "Строит гнезда", "Откладывает яйца", "Ковыляет"]),
    Question(question: "Почему змеи высовывают язык?", whriteAnswer: "Чтобы «понюхать» воздух", answers: ["Чтобы напугать хищников", "Чтобы облизать добычу", "Чтобы издать шипящий звук", "Чтобы «понюхать» воздух"]),
    Question(question: "Как называется явление, обозначающее, что на Земле не осталось ни одного животного конкретного вида?", whriteAnswer: "Вымирание", answers: ["Вымирание", "Находящиеся под угрозой исчезновения", "Сохранение", "Эволюция"]),
    Question(question: "Какая планета самая большая в Солнечной системе?", whriteAnswer: "Юпитер", answers: ["Юпитер", "Сатурн", "Нептун", "Меркурий"])
]
