import Playgrounds

#Playground {
    /// 도전 프로젝트: 함수형 카드 게임
    
    enum Suit: String, CaseIterable {
        case spade = "♠️", heart = "🖤", diamond = "◆", club = "♣️"
    }
    
    enum Rank: Int, CaseIterable {
        case two = 2, three, four, five, six, seven
        case eight, nine, ten
        case jack = 11, queen = 12, king = 13, ace = 14
    }
    
    struct Card {
        let suit: Suit
        let rank: Rank
        var description: String { "\(suit.rawValue)\(rank.rawValue)" }
    }
    
    //      52장 덱 생성 (flatMap)
    let deck = Suit.allCases.flatMap { suit in
        Rank.allCases.map { Card(suit: suit, rank: $0) }
    }
    print("전체: \(deck.count)장")
    
    
    //      셔플 후 5장 뽑기
    let hand = Array(deck.shuffled().prefix(5))
    hand.forEach { print($0.description) }
    
    
    //      카드 출력 + 합계
    print("합계: \(hand.map { $0.rank.rawValue }.reduce(0, +))")
    
    
    //      하트만 / 10 이상만 / 최고.최저 카드 분석
    let hearts = hand.filter { $0.suit == .heart }
    let highCards = hand.filter { $0.rank.rawValue >= 10 }
    let best = hand.max(by: { $0.rank.rawValue < $1.rank.rawValue })
    let worst = hand.min(by: { $0.rank.rawValue < $1.rank.rawValue })
    
    print("하트: \(hearts.map { $0.description })")
    print("10 이상: \(highCards.map { $0.description })")
    print("최고: \(best?.description ?? "-")")
    print("최저: \(worst?.description ?? "-")")
}
