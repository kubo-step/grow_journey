'use strict';

document.addEventListener('turbo:load', function() {
  setupEventListeners();
});

function setupEventListeners() {
  const modal = document.getElementById('modal');
  const mask = document.getElementById('mask');
  const modalImage = document.getElementById('modalImage');

  // イベント委任を使用して、トグルボタンの変更イベントをハンドル
  document.body.addEventListener("change", function(event) {
    const toggleButton = event.target;
    if (toggleButton.matches('[id^="toggle-button-"]')) {
      if (toggleButton.checked) {
        modal && modal.classList.remove('hidden');
        mask && mask.classList.remove('hidden');
        modalImage && modalImage.classList.remove('hidden');
        sendCheckboxState(toggleButton);
      } else {
        sendCheckboxState(toggleButton).then(() => {
          Turbo.visit(window.location.href);
        });
      }
    }
  });

  // クローズボタンのイベントリスナー
  const close = document.getElementById('close');
  if (close) {
    close.addEventListener('click', () => {
      modal && modal.classList.add('hidden');
      mask && mask.classList.add('hidden');
      modalImage && modalImage.classList.add('hidden');
      location.reload();
    });
  }

  // マスクのイベントリスナー
  if (mask) {
    mask.addEventListener('click', () => {
      close && close.click();
    });
  }
}

function sendCheckboxState(toggleButton) {
  const goalId = toggleButton.id.split('-')[2]; // goal.id の抽出
  const checked = toggleButton.checked;

  return fetch(`/goals/${goalId}/toggle`, {
    method: 'PATCH',
    headers: {
      'X-CSRF-Token': getCSRFToken() // CSRF トークンの取得
    },
    body: JSON.stringify({ checked: checked })
  })
  .then((response) => {
    if (!response.ok) {
      throw new Error('Network response was not ok');
    }
  })
  .catch((error) => {
    console.error('エラーが発生しました:', error);
  });
}

function getCSRFToken() {
  const metaTag = document.querySelector('meta[name="csrf-token"]');
  return metaTag ? metaTag.content : '';
}