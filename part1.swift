import Playgrounds

#Playground {
    /// Part 1. 기본 문법 연습문제
    
    // 2-1. 함수
    
    func introduce(name: String, age: Int = 20) {
        print("이름은 \(name)이고, 나이는 \(age)살 입니다.")
    }
    
    introduce(name: "홍길동", age: 25)
    introduce(name: "김철수")
    
    
    // 2-2. 함수 타입
    
    func double(_ n: Int) -> Int { n * 2 }
    func triple(_ n: Int) -> Int { n * 3 }
    
    var transform: (Int) -> Int = double
    print(transform(5))
    
    transform = triple
    print(transform(5))
    
    
    func applyAll(_ numbers: [Int], _ fn: (Int) -> Int) -> [Int] {
        numbers.map { fn($0) }
    }
    
    print(applyAll([1, 2, 3], double))
    
    
    
    // 2-3. 클로저
    
//  let sum: (Int, Int) -> Int = { (a: Int, b: Int) -> Int in
//      return a + b
//  }
    
    let sum: (Int, Int) -> Int = { $0 + $1 }
    
//  let upper: (String) -> String = { (str: String) -> String in
//      return str.uppercased()
//  }
    
    let upper: (String) -> String = { $0.uppercased() }
    
//  let isEven: (Int) -> Bool = { (n: Int) -> Bool in
//      return n % 2 == 0
//  }
    
    let isEven: (Int) -> Bool = { $0 % 2 == 0 }
    
    
    
    
    // 2-4. 후행 클로저
    
    func animate(duration: Double, animation: () -> Void) { }
    func fetch(url: String, completion: (String) -> Void) { }
    func retry(count: Int, action: (Int) -> Bool) { }
    
//  animate(duration: 0.3, animation: { print("애니메이션") })
//  fetch(url: "http://api.example.com", completion: { data in print(data) })
//  retry(count: 3, action: { attempt in return attempt < 3 })
    
    animate(duration: 0.3) { print("애니메이션") }
    fetch(url: "http://api.example.com") { print($0) }
    retry(count: 3) { $0 < 3 }
    
    
    
    // 2-5. 고차함수
    
    let numbers = [ 1, 2, 3, 4, 5, 6, 7, 8, 9, 10 ]
    let words = [ "Swift", "Kotlin", "Java", "Python", "Go" ]
    
    //      홀수만 골라서 제곱
    let result1 = numbers
        .filter { $0 % 2 != 0 }
        .map { $0 * $0 }
    
    //      6글자 이상 단어만 대문자로
    let result2 = words
        .filter { $0.count >= 6 }
        .map { $0.uppercased() }
    
    //      전체 합계
    let result3 = numbers.reduce(0, +)
    
    //      문자열 배열에서 숫자만 추출
    let mixed = [ "1", "a", "2", "b", "3" ]
    let result4 = mixed.compactMap { Int($0) }
    
    
    // 2-6. 열거형
    
    enum Season: String, CaseIterable {
        case spring = "봄"
        case summer = "여름"
        case fall = "가을"
        case winter = "겨울"
        
        //      각 계절에 맞는 추천 활동 반환하는 프로퍼티
        var activity: String {
            switch self {
            case .spring: return "꽃구경"
            case .summer: return "수영"
            case .fall: return "단풍놀이"
            case .winter: return "스키"
            }
        }
        
        //      다음 계절을 반환하는 함수
        func next() -> Season {
            switch self {
            case .spring: return .summer
            case .summer: return .fall
            case .fall: return .winter
            case .winter: return .spring
            }
        }
    }
    
    //      모든 계절과 추천 활동 출력
    for season in Season.allCases {
        print("\(season.rawValue): \(season.activity)")
    }
    
    //      다음 계절 출력
    print(Season.fall.next().rawValue)
    
    
    
    
    // 2-7. Associated Value
    
    enum LoginResult {
        case success(userId: String, token: String)
        case failure(code: Int, message: String)
        case twoFactor(phone: String)
    }
    
    //      아래 각 케이스를 switch로 처리하는 함수 작성
    func handleLogin(_ result: LoginResult) {
        switch result {
        case .success(let userId, _):
            print("로그인 성공: \(userId)")
        case .failure(let code, let message):
            print("로그인 실패: (\(code)): \(message)")
        case .twoFactor(let phone):
            print("2단계 인증 필요: \(phone)")
        }
    }
    
    //      테스트
    handleLogin(.success(userId: "user123", token: "abc-token"))
    handleLogin(.failure(code: 401, message: "비밀번호 오류"))
    handleLogin(.twoFactor(phone: "010-****-5678"))
}
