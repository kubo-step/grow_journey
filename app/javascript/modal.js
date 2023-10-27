'use strict';

document.addEventListener('turbo:load', function() {
  const close = document.getElementById('close');
  const modal = document.getElementById('modal');
  const mask = document.getElementById('mask');
  const modalImage = document.getElementById('modalImage');

  const toggleButtons = document.querySelectorAll('[id^="toggle-button-"]');

  toggleButtons.forEach((toggleButton) => {
    toggleButton.addEventListener("change", function(e) {
      if (toggleButton.checked) {
        modal.classList.remove('hidden');
        mask.classList.remove('hidden');
        modalImage.classList.remove('hidden');
        // チェックボックスの状態をサーバーに送信
        sendCheckboxState(toggleButton);
      } else {
        // チェックが外れた場合の処理
        sendCheckboxState(toggleButton);
        location.reload();
      }
    });
  });
  if (!close){ return false;}
    close.addEventListener('click', () => {
      modal.classList.add('hidden');
      mask.classList.add('hidden');
      modalImage.classList.add('hidden');
      location.reload();
    });
  if (!mask){ return false;}
    mask.addEventListener('click', () => {
      close.click();
    });

  function sendCheckboxState(toggleButton) {
    const goalId = toggleButton.id.split('-')[2]; // goal.id の抽出
    const checked = toggleButton.checked;

    // Ajax リクエストを使用してサーバーにチェックボックスの状態を送信
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
      const errorMessage = 'An error occurred. Please try again later.';
    });
  }

  function getCSRFToken() {
    const metaTag = document.querySelector('meta[name="csrf-token"]');
    if (metaTag) {
      return metaTag.content;
    }
    return '';
  }
});