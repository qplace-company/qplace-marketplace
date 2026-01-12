# QPlace Marketplace

QPlace 직원을 위한 Claude Code 플러그인 마켓플레이스.

## 설치

```bash
# 마켓플레이스 추가
claude plugin marketplace add qplace-company/qplace-marketplace

# 플러그인 설치
claude plugin install qplace-super-power
```

## 포함된 플러그인

| 플러그인 | 설명 | 카테고리 |
|---------|------|---------|
| [qplace-super-power](./plugins/qplace-super-power) | 병렬 에이전트 실행, 모든 외부 도구 총동원, 완료 강제 모드 | productivity |

## 의존성

qplace-super-power 플러그인을 사용하려면 다음 플러그인들이 **반드시** 활성화되어 있어야 합니다:

```bash
# 필수 플러그인
claude plugin install code-simplifier  # 코드 단순화 검증
claude plugin install code-reviewer    # 버그/보안 코드 리뷰
```

권장 플러그인:
- `context7` - 공식 라이브러리 문서 검색
- `playwright` - 웹 자동화 테스트
- `greptile` - PR 분석
- `figma` - UI/UX 디자인 작업

## 새 플러그인 추가

새 플러그인을 추가하려면:

1. `plugins/` 디렉토리에 플러그인 폴더 생성
2. `.claude-plugin/marketplace.json`의 `plugins` 배열에 플러그인 정보 추가
3. 플러그인 폴더에 `.claude-plugin/plugin.json` 작성

### 플러그인 구조

```
plugins/
└── your-plugin/
    ├── .claude-plugin/
    │   └── plugin.json      # 플러그인 메타데이터
    ├── agents/              # 서브에이전트 정의 (선택)
    ├── hooks/               # 훅 정의 (선택)
    ├── skills/              # 스킬 정의 (선택)
    ├── README.md            # 플러그인 문서
    └── settings.template.json  # 설정 템플릿 (선택)
```

## 라이선스

Private - QPlace 내부 사용 전용
