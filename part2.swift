import Playgrounds

#Playground {
    /// Part 2. 종합 프로젝트
    
    // 1. 함수형 성적 처리기: for문 없이 고차함수만 사용해서 성적 데이터를 처리하시오.
    let scores = [
        ("홍길동", [85, 90, 78, 92, 88]),
        ("김철수", [70, 65, 80, 75, 72]),
        ("이영희", [95, 98, 92, 96, 100]),
        ("박민준", [60, 55, 70, 65, 58]),
        ("최수진", [88, 82, 90, 85, 91])
    ]
    
    //      각 학생의 평균 계산 (map)
    let average = scores.map { (name, s) in
        (name, Double(s.reduce(0, +)) / Double(s.count))
    }
    
    //      평균 80점 이상인 학생만 추출 (filter)
    let highScore = average.filter { $0.1 >= 80 }
    
    //      평균 기준 내림차순 정렬 (sorted)
    let sorted = average.sorted { $0.1 > $1.1 }
    
    //      순위와 함께 출력 (enumerated + forEach)
    sorted.enumerated().forEach { idx, student in
        print("\(idx + 1)위: \(student.0) (\(String(format: "%.1f", student.1))점)")
    }
    
    //      전체 평균 (reduce)
    let totalAvg = average.map { $0.1 }.reduce(0, +) / Double(average.count)
    print("전체 평균: \(String(format: "%0.1f", totalAvg))점")
    
    
    
    // 2. 클로저 파이프라인
        
    typealias Transform = (String) -> String
    
    let trim: Transform = { $0.trimmingCharacters(in: .whitespaces) }
    let lowercase: Transform = { $0.lowercased() }
    let removeSpecial: Transform = { String($0.filter { $0.isLetter || $0.isNumber || $0 == " " })
    }
    
    func pipeline(_ input: String, transforms: [Transform]) -> String {
        transforms.reduce(input) { result, transform in transform(result) }
    }
    
    let input = "  Hello, Swift World! 123  "
    let result = pipeline(input, transforms: [trim, lowercase, removeSpecial])
    print(result)       // "hello swift world 123"
    
    
    
    // 3. 열거형 기반 RPG 캐릭터
    enum Job {
        case warrior, mage, archer
        
        var baseHp: Int {
            switch self {
            case .warrior: return 1500
            case .mage: return 800
            case .archer: return 1000
            }
        }
        var baseAttack: Int {
            switch self {
            case .warrior: return 80
            case .mage: return 120
            case .archer: return 100
            }
        }
        var description: String {
            switch self {
            case .warrior: return "전사 (근접 탱커)"
            case .mage: return "마법사 (원거리 마법 딜러)"
            case .archer: return "궁수 (원거리 물리 딜러)"
            }
        }
    }
    
    enum Skill {
        case attack
        case magic(power: Int)
        case heal(amount: Int)
        case buff(stat: String, value: Int)
        var description: String {
            switch self {
            case .attack: return "기본 공격"
            case .magic(let p): return "마법 송격 (위력: \(p)"
            case .heal(let a): return "체력 회복 (+\(a))"
            case .buff(let stat, let val): return "\(stat) 버프 (+\(val))"
            }
        }
    }
    
    let myJob = Job.mage
    print("직업: \(myJob.description)")
    print("HP: \(myJob.baseHp), 공격력: \(myJob.baseAttack)")
    
    let skills: [Skill] = [
        .attack, .magic(power: 150), .heal(amount: 50), .buff(stat: "공격력", value: 20)
    ]
    
    print("=== 스킬 목록 ===")
    skills.forEach { print($0.description) }
}
