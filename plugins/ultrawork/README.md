# Ultrawork Plugin for Claude Code

oh-my-opencode의 Sisyphus/Ultrawork 패턴을 Claude Code에 구현한 플러그인.

## 특징

- **병렬 에이전트 실행**: 탐색 작업을 백그라운드에서 동시 실행
- **모든 외부 도구 총동원**: Context7, WebSearch, Playwright, Greptile, Figma MCP 등
- **Oracle 아키텍처 자문**: 복잡한 결정에 opus 모델 적극 활용
- **Todo 완료 강제**: 모든 작업 완료 전까지 중도 포기 방지

## 의존성

이 플러그인을 사용하려면 다음 플러그인들이 필요합니다.

### 필수 플러그인 (Required)

검증 단계에서 사용되므로 반드시 활성화해야 합니다:

| 플러그인 | 마켓플레이스 | 용도 |
|---------|-------------|------|
| `code-simplifier` | claude-plugins-official | 코드 단순화 검증 |
| `code-reviewer` | claude-plugins-official | 버그/보안 코드 리뷰 |

```bash
claude plugin install code-simplifier
claude plugin install code-reviewer
```

### 권장 플러그인 (Recommended)

전체 기능을 활용하려면 다음 플러그인도 활성화를 권장합니다:

| 플러그인 | 마켓플레이스 | 용도 |
|---------|-------------|------|
| `context7` | claude-plugins-official | 공식 라이브러리 문서 검색 (librarian 에이전트) |
| `playwright` | claude-plugins-official | 웹 자동화 테스트 |
| `greptile` | claude-plugins-official | PR 분석 및 코드 리뷰 |
| `figma` | claude-plugins-official | UI/UX 디자인 작업 |

## 설치

### Claude Code Plugin Marketplace

```bash
claude plugin install ultrawork
```

### 수동 설치

1. 이 레포지토리를 클론합니다:
```bash
git clone https://github.com/qplace-company/ultrawork-plugin.git
```

2. 프로젝트의 `.claude/` 디렉토리에 파일들을 복사합니다:
```bash
cp -r ultrawork-plugin/agents/* your-project/.claude/agents/
cp -r ultrawork-plugin/skills/* your-project/.claude/skills/
```

3. (선택) `settings.template.json`의 내용을 프로젝트의 `.claude/settings.json`에 병합합니다.

## 사용법

프롬프트에 `ultrawork` 또는 `ulw` 키워드를 포함하면 Ultrawork 모드가 활성화됩니다.

```
ultrawork: 새로운 API 엔드포인트를 추가해줘
```

또는

```
ulw 사용자 인증 기능 구현해줘
```

## 에이전트 구성

| Agent | Model | 역할 |
|-------|-------|------|
| sisyphus-orchestrator | opus | 메인 오케스트레이터. 계획, 위임, 복잡한 작업 실행. 병렬 실행 강조 |
| oracle | opus | 아키텍처, 코드 리뷰, 전략. 논리적 추론과 심층 분석 |
| librarian | sonnet | 멀티 레포 분석, 문서 검색, 구현 예제. 증거 기반 답변 |
| explore | haiku | 빠른 코드베이스 탐색, 패턴 매칭 |
| frontend-ui-ux-engineer | sonnet | 디자이너 출신 개발자. 아름다운 UI 구축 |
| document-writer | sonnet | 기술 문서 작성 전문가 |
| multimodal-looker | sonnet | 시각 콘텐츠 전문가. PDF, 이미지, 다이어그램 분석 |

## 워크플로우

```
1. 사용자 알림 출력

2. 탐색 (병렬 백그라운드)
   ├── explore: 코드베이스 탐색
   ├── librarian: 외부 문서 검색
   └── multimodal-looker: 이미지/PDF 분석

3. 아키텍처 자문 (필요시)
   └── oracle: 복잡한 결정

4. 구현
   ├── 직접 구현 또는
   └── frontend-ui-ux-engineer: UI 작업

5. 검증 (순차)
   ├── code-simplifier (Claude 공식)
   └── code-reviewer (Claude 공식)

6. 완료 확인
   └── 모든 Todo 완료 시까지 반복
```

## 핵심 원칙

1. **직접 코드 작성 금지** - 모든 구현은 전문 에이전트에게 위임
2. **탐색 작업은 백그라운드 병렬 실행** - explore, librarian, multimodal-looker
3. **서브에이전트 결과는 반드시 검증** - "서브에이전트는 거짓말한다"
4. **Todo로 진행상황 추적** - 모든 작업은 Todo로 관리
5. **모든 외부 도구 적극 활용** - Context7, WebSearch, Playwright, Greptile, Figma MCP
6. **완료까지 멈추지 않음** - 모든 Todo 완료 전까지 계속 진행

## 외부 도구 활용

| 용도 | 도구 | 우선순위 |
|------|------|---------|
| 공식 문서 | Context7 | 1순위 |
| 최신 정보 | WebSearch | 2순위 |
| 특정 URL | WebFetch | 3순위 |
| 웹 자동화 | Playwright | 테스트 시 |
| PR 분석 | Greptile | PR 작업 시 |
| 디자인 | Figma MCP | UI 작업 시 |

## 영감

- [oh-my-opencode](https://github.com/manikmagar/oh-my-opencode) - Sisyphus/Ultrawork 패턴
- [AmpCode](https://ampcode.dev/) - Oracle, Librarian 개념

## 라이선스

MIT
