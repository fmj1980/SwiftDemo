//
//  ViewController.swift
//  swiftDemo
//
//  Created by fmj on 14-6-3.
//  Copyright (c) 2014年 fmj. All rights reserved.
//

import UIKit

var globalProperty:Int{
get{
    return 1
}
}

extension Int{
    func repetitions(task:(Int)->()){
        for i in 0..self{
            task(i);
        }
    }
}

struct point
{
    var x = 1.0,y:Double = 1.0
    mutating func move(){
        x = 2.0
    }
}

enum TrainStatus
{
    case OnTime,Delayed(Int)
    init(){
        self = OnTime;
    }
    
    var des:String{
    get
    {
        switch self{
        case OnTime:
            return "OnTime"
        case Delayed(let minutes):
            return "delayed\(minutes)minute"
        }
    }
    }
}

class BaseClass:NSObject
{
    var speed = 0.0
    func test()
    {
        var index:Int = 10;
        index.repetitions{(index) in println(index)}
        var pt = point(x:1.0,y:2.0)
        pt.move();
        var status:TrainStatus = .Delayed(10);
        var des = status.des;
        var name = getStudent({(name:String) in println(name)}).name
        let printClosure:()->() = {println(name)}
        printClosure();
    }
    
    func getStudent(task:(String)->Void)->(name:String,age:Int)
    {
        var dic:Dictionary = ["fmj" : 34 , "hym":35]
        for (name,age) in dic{
            task(name)
        }
        var index = dic.startIndex;
        var result = dic[index];
        return result;
    }
    
}

class SubClass:BaseClass
{
    //TODO:
    var base:BaseClass = BaseClass()
    var baseclass:BaseClass?;
    
    override var speed:Double
    {
    willSet(value){
        //baseclass = self;
        if let index = baseclass?.speed
        {
            println("optional chain")
        }
        if value > 200.0 {
            println("over speed");
        }
    }
    didSet(value){
        println("add \(value - speed) speed");
    }
    }
}

protocol ExampleProtocol {
    var simpleDescription: String { get }
     func adjust()->String
}

extension Int: ExampleProtocol {
    var simpleDescription: String {
        get{
            return "The number \(self)"
        }
    }
     func adjust()->String {
        return self.simpleDescription;
    }
}

typealias MyPoint = (Float, Float)

struct Vector2D {
    var x = 0.0
    var y = 0.0
    mutating func moveByX(deltaX: Double, y deltaY: Double) {
        self = Vector2D(x: x + deltaX, y: y + deltaY)
    }
}
@infix func + (left: Vector2D, right: Vector2D) -> Vector2D {
    return Vector2D(x: left.x + right.x, y: left.y + right.y)
}
@prefix func - (vector: Vector2D) -> Vector2D {
    return Vector2D(x: -vector.x, y: -vector.y)
}
@postfix func --(vector:Vector2D) -> Vector2D{
    return Vector2D(x:vector.x-1, y: vector.y-1)
}
@assignment func += (inout left: Vector2D, right: Vector2D) {
    left = left + right
}

@prefix @assignment func ++ (inout vector: Vector2D) -> Vector2D {
    vector += Vector2D(x: 1.0, y: 1.0)
    return vector
}
@infix func == (left: Vector2D, right: Vector2D) -> Bool {
    return (left.x == right.x) && (left.y == right.y)
}

@infix func != (left: Vector2D, right: Vector2D) -> Bool {
    return !(left == right)
}

//自定义操作符
operator prefix +++ {}
@prefix @assignment func +++ (inout vector: Vector2D) -> Vector2D {
    vector += vector
    return vector
}

func testOperator()
{
    
    var v1 = Vector2D(x:1.0,y:1.0),v2 = Vector2D(x:2.0,y:2.0)
    if v1 != v2
    {
        var v3 = v1+(-v2)
        var v4 = +++v1
        var v5 = v4--
    }
}

class SomeBaseClass {
    class func printClassName() {
        println("SomeBaseClass")
    }
}


class myViewController: UIViewController {
    class var classProper:String{
    return ""
    }
    var optionalInteger:String?
    var optionalInteger1:Optional<Int>
    var intArry:(Int[])?
    //var implicitlyUnwrappedString: String!
    var imOpitonValue1:ImplicitlyUnwrappedOptional<Int>
    var imOpitonValue:Int!
    var index:Int?;
    
    func addTwoNumbers(a: Int)(b: Int) -> Int {
        return a + b
    }
    func arithmeticMean(numbers: Double...) -> Double {
        var total: Double = 0
        for number in numbers {
            total += number
        }
        return total / Double(numbers.count)
    }
    
    func simpleAssert(condition: @auto_closure () -> Bool, message: String) {
        if !condition() {
            println(message)
        }
    }
    func getClosure()->((x:Int,y:Int)->Int)
    {
        return{(x, y) in
            return x + y
        }
    }
    func testClosure()
    {
        var closureStr = UIDevice();
        var addResult = {  $0 + $1 }(1,0);
        println(addResult)
        
        addResult = {
            [weak self,unowned closureStr]
            (var x, y:Int)
            in
            var result = x + y
            return result;
        }(1,2)
        println(addResult);
        
        var fun = getClosure()
        var funResult = fun(x:2,y:4);
        println(funResult)
        
        func makeIncrementer() -> (Int -> Int) {
            func addOne(number: Int) -> Int {
                return 1 + number
            }
            return addOne
        }
        var increase = makeIncrementer()(7)
        println( increase )
        
        let names = ["Chris", "Alex", "Ewa", "Barry", "Daniella"]
        func cmpfun(s1: String, s2: String) -> Bool {
            return s1 > s2
        }
        var reversed = sort(names, cmpfun)
        reversed = sort(names, { [weak self](s1: String, s2: String) -> Bool in return s1 > s2})
        reversed = sort(names, { s1, s2 in  return s1  > s2 } )
        reversed = sort(names, { $0 > $1 } )
        reversed = sort(names, >)
        names.sort(>);
        
        
        let digitNames = [
            0: "Zero", 1: "One", 2: "Two",   3: "Three", 4: "Four",
            5: "Five", 6: "Six", 7: "Seven", 8: "Eight", 9: "Nine"
        ]
        let numbers = [16, 58, 510]
        
        let strings = numbers.map {
            (var number) -> Int in
            var output = ""
            var count = 0;
            while number > 0 {
                output = digitNames[number % 10]! + output
                number /= 10
                count++
            }
            return count
        }
        println(strings)
    }
    
    func testModel()
    {
        func swapTwoValues<T>(inout a: T, inout b: T) {
            let temporaryA = a
            a = b
            b = temporaryA
        }
        var first = 1
        var second = 2
        swapTwoValues(&first, &second)
        
        func anyCommonElements <T, U where T: Sequence, U: Sequence, T.GeneratorType.Element: Equatable, T.GeneratorType.Element == U.GeneratorType.Element> (lhs: T, rhs: U) -> Bool {
            for lhsItem in lhs {
                for rhsItem in rhs {
                    if lhsItem == rhsItem {
                        return true
                    }
                }
            }
            return false
        }
        var result = anyCommonElements([1, 2, 3], [3])
        println(result);
    }
    
    func testOptionalValue()
    {
        if(imOpitonValue == nil){imOpitonValue=1;}
        if(optionalInteger == nil){optionalInteger =  "fmj";}
        println(optionalInteger!);
    }
    func testSubScript()
    {
        var current = self[0];
        println(current);
        self[0] = 10;
        var result = self[0];
        println(result);
    }
    
    enum FM_ENUM
    {
        case FM_INT(Int,Int,Int)
        case FM_STRING(String)
    }
    enum ASCIIControlCharacter: String {
        case Tab = "TAB"
        case LineFeed = "LINED"
        case CarriageReturn = "CARR"
    }
    enum Planet: Int {
        case Mercury = 1, Venus, Earth, Mars, Jupiter, Saturn, Uranus, Neptune
    }
    func testEnum()
    {
        let enumValue = FM_ENUM.FM_INT(1,2,3)
        var enumStr = FM_ENUM.FM_STRING("fmj")
        switch(enumValue){
        case .FM_INT(let a,let b, let c):
            println(a);
        }
        var cha = ASCIIControlCharacter.Tab;
        let raw = ASCIIControlCharacter.fromRaw("TAB")
        println(raw!.toRaw());
        
        if let raw1 = ASCIIControlCharacter.fromRaw("TAB"){
            println(raw1.toRaw());
        }
    }
    
    
    func testProtocol(pro:ExampleProtocol)
    {
        var result = pro.adjust()
        println(result);
    }
    func testProtocolAndExtension(){
        var index = 2;
        var des = index.simpleDescription;
        testProtocol(index);
    }

    //swift的let数组不可以修改大小，但是可以修改内容  dictionay既不可以修改大小，也不可以修改内容
    func testArray()
    {
        var range:Range<Int> = 1...4
        var buffer:Sequence = range
        
        var arry:Array = Any[]();
        arry.append(0);
        arry.append(0.0);
        arry.append(1);
        arry.append("2");
        arry.append((11,11));
        arry.append([13,14]);
        arry.append(["name":"fmj"])
        arry += "hello"
        fmj:for item in arry
        {
            switch item{
            case 0 as Int:
                println( (item as Int) - 1 )
                //TODO:
                fallthrough
            case 0 as Double:
                println("Double")
            case is Double:
                println("is double")
            case is String:
                println(item as String)
            case let(int1,int2) as (Int,Int) where int1 == int2:
                println(int1)
            case is Int[]:
                println((item as Int[])[0])
            case is Dictionary<String,String>:
                println( (item as Dictionary<String,String>)["name"])
            default:
                println("default")
            }
            //todo:
            if false{
                break fmj
            }
        }
        var arry1 = arry;
        
        println(arry)
        
        arry1[0] = "4"
        println(arry)
        println(arry1)
        
        arry1.unshare()
        arry1[1] = "5"
        println(arry)
        println(arry1)

        arry.append(7);
        
        println(arry)
        println(arry1)
        
        arry[1...2]=[100,101]
        println(arry)
        
        arry.insert("index",atIndex:0)
        arry.removeAtIndex(arry.count-1)
        arry.removeLast()
        println(arry)
        
        for (index,_) in enumerate(arry){
            println("idnex:\(index)")
        }
        
        var defaultIntArry = Int[](count:3,repeatedValue:1)
        var defaultDoubleArry:Array<Int> = Array(count:3,repeatedValue:10)
        var newArry = defaultDoubleArry + defaultIntArry
        println(newArry)
    }
    
    func testDictionary()
    {
        var dic:Dictionary<String,Int> = [:];
        dic["fmj"]=34;
        dic["hym"] = 35
        if let oldValue = dic.updateValue(35, forKey:"fmj"){
            println( "oldvalue\(oldValue)" )
        }
        if  let value = dic["test"]{
        }
        else
        {
            println("no test value")
        }
        dic["hym"] = nil
        if let removeValue = dic.removeValueForKey("hym"){
            
        } else{
            println("no hym value")
        }
        println(dic["c"]);
        for (name,age) in dic
        {
            println(age);
        }
        for name in dic.keys{
            println(name)
        }
        let keys = Array(dic.keys)
        let aa = Array(0...1)
    }
    
    func swapTwoInts(inout a: Int, inout swapb b: Int) {
        let temporaryA = a
        a = b
        b = temporaryA
    }
    
    func testInOut(inout index:Int){
      index = 10
    }
    
    func testTuple(var key:Int, name:Int = 1)->Void
    {
        key = 20
        println(name)
        let yetAnotherPoint = (1, -1)
        let (x,y) = yetAnotherPoint
        switch yetAnotherPoint {
        case let (x, y)  where x == y:
            println("(\(x), \(y)) is on the line x == y")
        case let (x, y) where x == -y:
            println("(\(x), \(y)) is on the line x == -y")
        case let (x, y):
            println("(\(x), \(y)) is just some arbitrary point")
        }
    }

    
    override func viewDidLoad() {
        
        var arr1 = [2,3,4]
        var arr2 = arr1;
        if arr1[1..2] === arr2[1..2]{
            println("＝＝＝＝")
        }
        super.viewDidLoad()
        var name = "abc"
        var someInt = 3, anotherInt = 107
        
        swapTwoInts(&someInt, swapb:&anotherInt)
        testInOut(&someInt)
        testClosure();
        testSubScript();
        testModel();
        testOperator();
        testEnum();
        testArray();
        testDictionary();
        
        //todo:
        var fun1:()->(Int,name:Int)->Void = { return self.testTuple}
        fun1()(someInt,name:1)
        
        var testClass = SubClass(); testClass.speed = 2;
        testClass.test();
        
        let someInstance: SomeBaseClass = SomeBaseClass()
        someInstance.dynamicType.printClassName();
        SomeBaseClass.printClassName();
        
        let testNumber = 5
        simpleAssert(testNumber % 2 == 0,message: "testNumber isn't an even number.")
        
        let point:MyPoint = (1.0,2.0)
        let(xPoint,yPoint)=point
        println("x:\(xPoint) y:\(yPoint)");
        
        let obj = myObject()
        obj.test()
        
        let people = ["Anna": 67, "Beto": 8, "Jack": 33, "Sam": 25]
        for (name, age) in people {
            println("\(name) is \(age) years old.")
        }
    
        var a1 = "f" as String;
        var u = a1.uppercaseString;
        
        var par = ("123",1,5);
        print(par.0);
        
        let(a, _, (b, c)) = ("test", 9.45, (12, 3))
        
        for index in 1...5 {
            println("\(index) times 5 is \(index * 5)")
        }
        
        let(_,message) = (404, "Not Found")
        println( message )
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    
    subscript(index:Int)->Int
    {
        get
        {
            if(self.index == nil)
            {
                return 0;
            }
            return self.index!
        }
        set(value)
        {
            self.index = value;
        }

    }
  

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    

}


