document.addEventListener('DOMContentLoaded', () => {
  // csrf-tokenを取得
  const token = document.querySelector('meta[name="csrf-token"]').getAttribute('content');
  const LIFF_ID = gon.liff_id;

  liff
  .init({
    liffId: LIFF_ID,
    withLoginOnExternalBrowser: true
  })
    // 初期化後の処理の設定
  liff
  .ready.then(() => {
    const idToken = liff.getIDToken()
    // bodyにパラメーターの設定
    const body =`idToken=${idToken}`
    // リクエスト内容の定義
    const request = new Request('/users', {
      headers: {
        'Content-Type': 'application/x-www-form-urlencoded; charset=utf-8',
        'X-CSRF-Token': token
      },
      method: 'POST',
      body: body
    });

    // リクエストを送る
    fetch(request)
    // jsonでレスポンスからデータを取得して/goalsに遷移する
    .then(response => response.json())
    .then(data => {
      data_id = data
    })
    .then(() => {
      window.location = '/goals'
    })
    .catch((err) => {
      console.log(err);
    })
  })
});