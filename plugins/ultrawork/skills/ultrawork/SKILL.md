---
name: ultrawork
description: ulw 또는 ultrawork 키워드로 활성화되는 병렬 에이전트 오케스트레이션 모드. "ulw:", "ultrawork:", "ulw", "울트라워크" 입력 시 사용. 모든 외부 도구 총동원, 완료 강제 모드. oh-my-opencode의 Ultrawork/Sisyphus 패턴 구현.
---

# Ultrawork Mode

oh-my-opencode의 Ultrawork 패턴을 Claude Code에 구현한 모드.

프롬프트에 `ultrawork` 또는 `ulw` 키워드가 포함되면 이 모드가 활성화됩니다.

## 활성화 시 사용자 알림 (필수)

다음 배너를 **반드시** 출력하여 사용자에게 Ultrawork 모드 활성화를 명확히 알립니다:

```
╔════════════════════════════════════════════════════════════════╗
║  🚀 ULTRAWORK MODE ACTIVATED                                   ║
╠════════════════════════════════════════════════════════════════╣
║  ✓ 병렬 에이전트 실행 (explore + librarian + multimodal)       ║
║  ✓ 모든 외부 도구 총동원                                       ║
║  ✓ Oracle 아키텍처 자문 적극 활용                              ║
║  ✓ Todo 완료 강제 (중도 포기 방지)                             ║
╚════════════════════════════════════════════════════════════════╝
```

## 활성화 시 자동 실행

1. **사용자 알림 출력** (위 배너)
2. **요청 분석** → Oracle 자문 → Todo 생성
3. **Explore + Librarian + Multimodal-looker 백그라운드 병렬 실행**
4. 결과 수집 후 구현 작업 진행
5. **code-simplifier:code-simplifier → feature-dev:code-reviewer 순차 검증**
6. **모든 Todo 완료까지 반복** (중도 포기 금지)

## 워크플로우

```
1. 사용자 알림 출력

2. 탐색 (병렬 백그라운드)
   ├── Task(explore, run_in_background=true)
   ├── Task(librarian, run_in_background=true)
   └── Task(multimodal-looker, run_in_background=true)

3. 아키텍처 자문 (필요시)
   └── Task(oracle): 복잡한 결정

4. 구현
   ├── 직접 구현 또는
   └── Task(frontend-ui-ux-engineer): UI 작업

5. 검증 (순차)
   ├── Task(code-simplifier:code-simplifier)
   └── Task(feature-dev:code-reviewer)

6. 완료 확인
   └── 모든 Todo 완료 시까지 반복
```

## 도구 활용 (모든 도구 적극 활용)

| 용도 | 도구 | 우선순위 |
|------|------|---------|
| 공식 문서 | Context7 | 1순위 |
| 최신 정보 | WebSearch | 2순위 |
| 특정 URL | WebFetch | 3순위 |
| 코드 탐색 | Explore 에이전트 | 1순위 |
| 코드 검색 | Grep | 2순위 |
| 웹 자동화 | Playwright | 테스트 시 |
| PR 분석 | Greptile | PR 작업 시 |
| 디자인 | Figma MCP | UI 작업 시 |

## 에이전트 위임

| 작업 | 에이전트 | 실행 방식 |
|------|---------|----------|
| 코드베이스 탐색 | explore | 백그라운드 |
| 외부 문서 검색 | librarian | 백그라운드 |
| 이미지/PDF 분석 | multimodal-looker | 백그라운드 |
| 아키텍처 자문 | oracle | 동기 (적극) |
| UI/UX 구현 | frontend-ui-ux-engineer | 동기 |
| 기술 문서 | document-writer | 동기 |
| 코드 단순화 | code-simplifier:code-simplifier | 동기 |
| 코드 리뷰 | feature-dev:code-reviewer | 동기 |

## 핵심 원칙

### 1. 병렬 실행
- 독립적인 탐색 작업은 동시에 백그라운드 실행
- 최대 3개 에이전트 동시 실행

### 2. 모든 도구 활용
- Context7, WebSearch, Playwright, Greptile, Figma MCP 등
- 사용 가능한 모든 MCP 도구 적극 활용

### 3. Oracle 적극 활용
- 품질 우선
- 복잡한 결정마다 Oracle 자문 요청

### 4. 완료 강제
- 모든 Todo 완료 전까지 멈추지 않음
- 중도 포기 금지

### 5. 검증 필수
- 서브에이전트 결과는 항상 검증
- "서브에이전트는 거짓말한다"

## 사용 예시

```
사용자: ultrawork: 새로운 API 엔드포인트 추가해줘

Claude:
╔════════════════════════════════════════════════════════════════╗
║  🚀 ULTRAWORK MODE ACTIVATED                                   ║
╠════════════════════════════════════════════════════════════════╣
║  ✓ 병렬 에이전트 실행 (explore + librarian + multimodal)       ║
║  ✓ 모든 외부 도구 총동원                                       ║
║  ✓ Oracle 아키텍처 자문 적극 활용                              ║
║  ✓ Todo 완료 강제 (중도 포기 방지)                             ║
╚════════════════════════════════════════════════════════════════╝

[Todo 생성]
[백그라운드 에이전트 실행]
[구현 진행]
...
```

$ARGUMENTS
