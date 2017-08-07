# Commonposter

- 一定範囲のユーザのみ閲覧可能(1m~10000m、初期値: 1200m)
- 掲載期限を設定可能(日付指定1年後まで、初期値: 1年後)
- 内容はタイトル(40文字)、ボディ(400文字)、画像(1枚)
- 月300円で範囲・期限を超えて掲載可能(範囲無制限、日付指定3年後まで)
- 1ポスター100円で範囲・期限を超えて掲載可能(範囲無制限、日付指定3年後まで)

## Resource Spec

- posters(id / usr_id / title / body / image_url / lang / long / expired_at / created_at / updated_at)

## Screen Spec

- LoginScreen
  - Button: loginButton(Login)
- MainScreen
  - View: Posters
    - Map: PosterMap(Pin posters)
    - List: PosterList(Show posters)
      - Link: PosterLink(Move to ShowPosterScreen)
  - View: Profile
    - List: PosterList(Show posters)
      - Link: PosterLink(Move to ShowPosterScreen)
  - Link: CreatePosterLink(Move to NewPosterScreen)
- ShowPosterScreen
  - Link: PosterLink(Move to EditPosterScreen)
  - View: PosterTitle
  - View: PosterBody
  - View: PosterImage
  - View: PosterMap
- NewPosterScreen / Editposterscreen
  - Button: createPosterButton(create / update)
  - Input: PosterExpiredAtInput
  - Input: PosterRadiusInput
  - Input: PosterTitleInput
  - Input: PosterBodyInput
  - Input: PosterImageInput


## About Screen Spec

- Screen Name
  - Component: ComponentName(feature)

Component: View / Button / Link / List / Input / Map
