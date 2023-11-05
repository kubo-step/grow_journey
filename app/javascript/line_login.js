document.addEventListener('DOMContentLoaded', () => {
  const token = document.querySelector('meta[name="csrf-token"]').getAttribute('content');
  const LIFF_ID = gon.liff_id;

  // liff関連のlocalStorageのキーのリストを取得
  const getLiffLocalStorageKeys = (prefix) => {
    const keys = []
    for (var i = 0; i < localStorage.length; i++) {
      const key = localStorage.key(i)
      if (key.indexOf(prefix) === 0) {
        keys.push(key)
      }
    }
    return keys
  }
  // 期限切れのIDTokenをクリアする
  const clearExpiredIdToken = (liffId) => {
  const keyPrefix = `LIFF_STORE:${liffId}:`
  const key = keyPrefix + 'decodedIDToken'
  const decodedIDTokenString = localStorage.getItem(key)
  if (!decodedIDTokenString) {
    return
  }
  const decodedIDToken = JSON.parse(decodedIDTokenString)
  // 有効期限をチェック
  if (new Date().getTime() > decodedIDToken.exp * 1000) {
      const keys = getLiffLocalStorageKeys(keyPrefix)
      keys.forEach(function(key) {
        localStorage.removeItem(key)
      })
  }
  }

  const main = async(liffId) => {
    clearExpiredIdToken(liffId)
  await liff
    .init({
      liffId: LIFF_ID,
      withLoginOnExternalBrowser: true
    })
  liff
    .ready.then(() => {
      if (!liff.isLoggedIn()) {
        liff.login();
      } else {
        liff.getProfile().then(profile => {
          const idToken = liff.getIDToken()
          const name = profile.displayName
          const body = `idToken=${idToken}&name=${name}`
          const request = new Request('/users', {
            headers: {
              'Content-Type': 'application/x-www-form-urlencoded; charset=utf-8',
              'X-CSRF-Token': token
            },
            method: 'POST',
            body: body
          });

          fetch(request)
            .then(response => response.json())
            .then(data => {
              data_id = data
            })
            .then(() => {
              window.location = '/goals'
            })
            .catch(error => {
              console.error('エラー:', error);
            });
        })
      }
    })
  }
  main();
})