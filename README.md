## MC3 Team18 For EllyJ Health

# :iphone: Piki Pick 

Apple Developer Academy @ POSTECH Mini Challenge #3 Project입니다. 
"Community Impact" 를 주제로 다양한 사회의 커뮤니티들이 직면한 문제를 해결하는 Impact를 만들어 보는 프로젝트를 진행했습니다. 
> Multipeer Connectivity를 통해 동일한 와이파이 환경, 또는 Peer-to-Peer 와이파이, 블루투스를 통해 청중들은 발표자의 기기 또는 아이패드에 연결합니다. 발표자는 AirPlay등을 사용해 큰 화면에 기기를 연결하거나 혹은 본인의 기기를 통해 청중들의 다양한 피드백과 질문 등을 받을 수있으며, 필요에 따라 4가지 Option의 투표를 진행할 수있습니다.
---
### Challenge : Apple Developer Academy @ POSTECH의 멘토들의 어려움을 알고 도와주자.
### Solution Concept : Multipeer Connectivity를 사용해 시니어 러너와 주니어 러너의 피드백을 도와주자.
### Boundaries 
- 네트워킹 : API optional, No backend
- Unity와 같은 게임 엔진 (X)
- 만날 수 없는 사용자를 위한 서비스 (X)
- 애플이 지원/보증하는 자원(1st Party) 우선 사용

---
1. For What `Situation`
- 애플 아카데미의 다양한 Presentation 상황
- 애플 아카데미의 다양한 행사
- 청중과의 다양한 Interactive한 발표가 필요한 강단

2. `Who` it's for
- 애플 아카데미의 TOD(Tip of the Day)의 발표자
- 애플 아카데미 토막상식을 준비하는 시니어 러너
- 애플 아카데미의 다양한 행사의 밣표자(ex: 영일대 익스프레스, asyncSwift 행사)
- 청중과 소통하며 발표를 진행하고자 하는 발표자


## :pushpin: Features

- Emoji Reaction : 발표자의 기기에 이모지로 다양한 Reaction을 보내는 기능
- Emoji Vote : Emoji를 통해 4가지 Option의 Vote를 할 수있는 기능
- PeedBack : Chat을 통해 발표자에게 질문을 보내는 기능
- Emoji Reaction View : 발표자가 청중들의 Emoji Reaction을 확인하는 기능
- Emoji Vote View : 발표자가 청중들의 4가지 Option의 Vote를 받고 확인할 수있는 기능
- PeedBack View : 발표자가 청중들의 다양한 질문들을 확인할 수 있는 기능


## :framed_picture: Demo

### [⭐️ PikiPick ⭐️](https://youtu.be/bBylSazJQlQ)유튜브 영상데모 보러가기
### [⭐️ 사용방법 ⭐️](https://youtu.be/0zftlcXqkXs)시뮬레이터 작동영상 보러가기

## 🌈 Design Guide 

![DsignGuide]()


## :fireworks: Screenshots

| HomeView | PeerView | RemoteView |
|:---:|:---:|:---:|
|![App Screenshot]()|![App Screenshot]()|![App Screenshot]()|

<br>

| PresentationView | PeedBackView | VoteView |
|:---:|:---:|:---:|
|![App Screenshot]()|![App Screenshot]()|![App Screenshot]()|

## :sparkles: Skills & Tech Stack
1. 이슈관리 : Miro
2. 형상관리 : Github
3. 커뮤니케이션 : Ryver, Notion, Zoom<br>
4. 개발환경
- OS : MacOS(M1Pro)
- IDE : Xcode 13.4.1
5. 상세사용
- Application : SwiftUI
- Design : Sketch, Figma, Illustrator<br>
6. 라이브러리
```swift
import swiftUI
import UIKit
import CoreData
import Combine
import MultipeerConnectivity
import Network
```
## 🔀 Git

1. Commit 컨벤션
    - `feat` : 새로운 기능 추가
    - `fix` : 버그 수정
    - `docs` : 문서 (README, 포팅메뉴얼)
    - `test` : 테스트 코드
    - `refactor` : 코드 리팩토링 (기능 말고 성능 개선)
    - `style` : 코드 의미에 영향을 주지 않는 변경 사항
    - `chore` : 빌드, 설정 파일
    - `comment` : 주석이 추가되는 경우.
    
2. 규칙
    - 제목의 길이는 50글자를 넘기지 않는다
    - 제목의 마지막에 마침표를 사용하지 않는다
    - 본문을 작성할 때 한 줄에 72글자 넘기지 않는다
    - 과거형을 사용하지 않는다
    - 커밋 메시지는 **영어 or 한글**로 작성한다   
```bash
feat: Summarize changes in around 50 characters or less

This is a body part. Please describe the details of commit.
```
3. Git 브랜치
    - `master` : 배포
    - `develop` : 개발된 기능(feature)을 통합하는 브랜치
    - `docs` : 문서작업 브랜치
    -  Convention/#Issues number
    - 띄어쓰기, 구분 필요한 경우 대쉬

## :people_hugging: Authors

- [@김형중](https://github.com/dkdo1406) | [@송시원](https://github.com/song-cool) | [@이준영](https://github.com/User-Lawn) | [정우영](https://github.com/woo0dev) | [@황정현](https://github.com/jeong-hyeonHwang)
  
## :books: Documentation

[Documentation](./Docs/)


## :lock_with_ink_pen: License
