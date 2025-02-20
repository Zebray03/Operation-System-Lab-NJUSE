@Entry
@Component
struct Index {
  @State message: string = 'Hello World';
  pathStack: NavPathStack = new NavPathStack();
  dialogController: CustomDialogController = new CustomDialogController({
    builder: CustomDialogToast(),
  })

  @Builder
  PageMap(name: string) {
    if (name === "next_page") {
      nextPageTmp()
    }
  }

  build() {
    Navigation(this.pathStack) {
      RelativeContainer() {
        Column({ space: 20 }) {
          Text(this.message)
            .id('HelloWorld')
            .fontSize($r('app.float.page_text_font_size'))
            .fontWeight(FontWeight.Bold)

          Button('Next', { type: ButtonType.Capsule, stateEffect: false })
            .width(160)
            .fontSize(32)
            .fontColor(0x000000)
            .fontWeight(FontWeight.Bold)
            .backgroundColor(0x0e9ffc)
            .onClick(() => {
              this.pathStack.pushPath({ name: "next_page" })
            })

          Button('Show toast', { type: ButtonType.Capsule, stateEffect: false })
            .fontSize(24)
            .fontColor(0xffffff)
            .backgroundColor(0xb666df)
            .onClick(() => {
              this.dialogController.open()
            })
        }.width('100%')
        .alignRules({
          center: { anchor: '__container__', align: VerticalAlign.Center },
          middle: { anchor: '__container__', align: HorizontalAlign.Center }
        })
      }
      .height('100%')
      .width('100%')
    }
    .mode(NavigationMode.Stack)
    .navDestination(this.PageMap)
  }
}

// nextPage
@Component
export struct nextPageTmp {
  @State message: string = 'Hi there';
  pathStack: NavPathStack = new NavPathStack();

  build() {
    NavDestination() {
      RelativeContainer() {
        Column({ space: 20 }) {
          Text(this.message)
            .id('Hi there')
            .fontSize($r('app.float.page_text_font_size'))
            .fontWeight(FontWeight.Bold)

          Button('Back', { type: ButtonType.Capsule, stateEffect: false })
            .width(160)
            .fontSize(32)
            .fontColor(0x000000)
            .fontWeight(FontWeight.Bold)
            .backgroundColor(0x0e9ffc)
            .onClick(() => {
              const popDestinationInfo = this.pathStack.pop()
              console.log('pop' + 'return' + JSON.stringify(popDestinationInfo))
              return true
            })
        }.width('100%')
        .alignRules({
          center: { anchor: '__container__', align: VerticalAlign.Center },
          middle: { anchor: '__container__', align: HorizontalAlign.Center }
        })
      }
      .height('100%')
      .width('100%')
    }
    .onReady((context: NavDestinationContext) => {
      this.pathStack = context.pathStack
    })
  }
}

@Component
@CustomDialog
struct CustomDialogToast {
  controller: CustomDialogController = new CustomDialogController({
    builder: CustomDialogToast({}),
  })

  build() {
    Column() {
      Text('Hello World')
    }
    .height(60)
    .justifyContent(FlexAlign.Center)
  }
}