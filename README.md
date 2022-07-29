![Artboard 1](https://user-images.githubusercontent.com/74142881/181747683-d50bb521-cad3-439e-bf44-6472ff7ed962.png)
---

# :iphone: Piki Pick 

Apple Developer Academy @ POSTECH Mini Challenge #3 Project입니다. 
"Community Impact" 를 주제로 다양한 사회의 커뮤니티들이 직면한 문제를 해결하는 Impact를 만들어 보는 프로젝트를 진행했습니다. 
> Multipeer Connectivity를 통해 동일한 와이파이 환경, 또는 Peer-to-Peer 와이파이, 블루투스를 통해 청중들은 발표자의 기기 또는 아이패드에 연결합니다. 
발표자는 AirPlay등을 사용해 큰 화면에 기기를 연결하거나 혹은 본인의 기기를 통해 청중들의 다양한 피드백과 질문 등을 받을 수있으며, 필요에 따라 4가지 Option의 투표를 진행할 수있습니다.


#### Challenge 
- Apple Developer Academy @ POSTECH의 멘토들의 어려움을 알고 도와주자.
#### Solution Concept 
- Multipeer Connectivity를 사용해 시니어 러너와 주니어 러너의 피드백을 도와주자.
#### Boundaries 
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
<br/>

## :pushpin: Features

- Emoji Reaction : 발표자의 기기에 이모지로 다양한 Reaction을 보내는 기능
- Emoji Vote : Emoji를 통해 4가지 Option의 Vote를 할 수있는 기능
- PeedBack : Chat을 통해 발표자에게 질문을 보내는 기능
- Emoji Reaction View : 발표자가 청중들의 Emoji Reaction을 확인하는 기능
- Emoji Vote View : 발표자가 청중들의 4가지 Option의 Vote를 받고 확인할 수있는 기능
- PeedBack View : 발표자가 청중들의 다양한 질문들을 확인할 수 있는 기능


## :framed_picture: Demo

#### [⭐️ PikiPick ⭐️](https://youtu.be/jQuChTe-K0I)유튜브 영상데모
#### [⭐️ 사용방법 ⭐️]()사용방법 시연 영상

## 🌈 Design Guide 

<img width="920" alt="스크린샷" src="https://user-images.githubusercontent.com/74142881/181621937-70aabd64-378a-46bc-a6a7-ed5d7cc8ee24.png">

## :fireworks: Screenshots

| HomeView | RemoteView | QuestionView |
|:---:|:---:|:---:|
|<img align='' alt="HomeView" src="https://user-images.githubusercontent.com/74142881/181611398-b58eb0c9-3760-4094-b4fa-90fe81bf952d.png" width= '500px'/></a>|<img align='' alt="RemoteView" src="https://user-images.githubusercontent.com/74142881/181611778-73a348d4-2e92-41f2-a863-efd67314b51c.png" width= '500px'/></a>|<img align='' alt="QuestionView" src="https://user-images.githubusercontent.com/74142881/181611414-11fcf9b7-3b6e-48fc-9374-f98a048f1c2d.png" width= '500px'/></a>|

<br>

| PresentationView |
|:---:|
|<img align='' alt="PresentationView" src="https://user-images.githubusercontent.com/74142881/181612665-748d6f02-f3de-4d03-90bb-8c25318e3c28.png" width= '700px'/></a>|

| PeedBackView |
|:---:|
|<img align='' alt="PeedBackView" src="https://user-images.githubusercontent.com/74142881/181622420-3bf8b696-9962-4044-af2b-2d050ee59c06.png" width= '700px'/></a>|

<br>

| VoteView |
|:---:|
|<img align='' alt="VoteView" src="https://user-images.githubusercontent.com/74142881/181612965-f21637c6-3d8a-47ab-a6b6-b344abafefbc.png" width= '700px'/></a>|


## :sparkles: Skills & Tech Stack
1. 이슈관리 : Miro
2. 형상관리 : Github
3. 커뮤니케이션 : Ryver, Notion, Zoom<br>
4. 개발환경
- OS : iOS 15.5
- IDE : Xcode 13.4.1
5. 상세사용
- Application : UIKit, SwiftUI
- Design : Sketch, Figma, Illustrator<br>
6. 라이브러리
```swift
import swiftUI
import UIKit
import OS
import CoreHpatics
import MultipeerConnectivity
import Network
```
## 🔀 Git

1. 기본적인 작업 프로세스
    - Issue 생성: Assignees 할당, Label 할당
    - Kanban 작성: Issue의 TODO를 바탕으로 칸반 작성하기
    - Branch 작성: Branch의 종류에 맞는 형태로 이름 지정
    - Work: Issue에서 작성했던 내용들을 기반으로 코드, 디자인 etc 구현
    - Pull Request: Issue의 TODO에서 제시되었던 모든 작업을 마친 후 PR 신청
    - 상위 Branch에 Merge하기 전, 상위 Branch의 변경 사항을 현재 작업했던 Branch로 들고와, 최대한 Conflict가 없게 만들기
    - 최소 2명 이상의 Reviewer의 Approve 후 Merge 가능

2. Phase: Issue
    - Issue 생성 규칙
    - 기본적으로는 이슈 템플릿을 사용하여 작성
    - 구현해야하는 요소들: 해결해야하는 문제에 대해 간략 서술
    - 구현 방안: 위의 요소들의 실제 구현 시의 세부 사항 및 방법을 작성한다

- 제목
    - 50자 이내
    - 단어 형태로 종결
```
ex) [FEAT] Add Notification Permission Error
ex) [FEAT] Notification 접근 권한 추가
```

- 본문
    - 80자 이내
    - 단어 형태로 종결
    - 작업 사항에 대한 간략한 설명

3. Phase: Branch
    - Branch 관리

- Main Branch
    - Dev Branch: For Development
    - View Branch: Development Branch 중에서도 View 단위로 관리하기 위한 Branch들
    - 개발 이외의 Branch는 언제든지 추가될 여지 존재

- Branch 생성 규칙

    - Default: 작업태그/이슈번호
    - View Branch: View이름/이슈번호
```
ex) FEAT/[FEAT] AudienceView (#7) #11
ex) HomeView/[FEAT] MainView #3
```

4. Phase: Pull Request

- PR(Pull Request) 규칙
    - [작업태그] 작업 사항 축약
    - ex) [FEAT] 회원가입 뷰 추가
    - PR 생성 후, 오른쪽 하단의 Development에서 연관된 이슈를 연결하기
    - Close #이슈넘버 의 형태로 자동 할당이 가능

- 작업태그 일괄
    - FEAT : 새로운 기능 추가 / 일부 코드 추가 / 일부 코드 수정(리팩토링과 구분)
    - FIX : 버그 수정
    - DOCS : 문서 수정
    - TEST : 테스트 코드 추가
    - REFACTOR : 코드 리팩토링
    - STYLE : 코드 의미에 영향을 주지 않는 변경사항
    - CHORE : 빌드 부분 혹은 패키지 매니저 수정사항
    
## :people_hugging: Authors

- [@김형중](https://github.com/dkdo1406) | [@송시원](https://github.com/song-cool) | [@이준영](https://github.com/User-Lawn) | [정우영](https://github.com/woo0dev) | [@황정현](https://github.com/jeong-hyeonHwang)
  
## :books: Documentation

[Documentation](./Docs/)


## :lock_with_ink_pen: License
