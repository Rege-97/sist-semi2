let playerTab = null;

function openPlayerFromHeader() {
  const url = "/semi2/player/player.jsp";

  if (!playerTab || playerTab.closed) {
    playerTab = window.open(url, "myFixedPlayerTab");
  } else {
    // 헤더에서는 메시지 전송 없이 포커스만
    playerTab.focus();
  }
}

function openOrReuseTabWithChannel(urlWithParams) {
  const fullUrl = new URL(urlWithParams, window.location.origin).toString();

  if (!playerTab || playerTab.closed) {
    playerTab = window.open(fullUrl, "myFixedPlayerTab");
  } else {
    // 파라미터가 있으니까 메시지로 보내서 새로고침 유도
    const channel = new BroadcastChannel("player-control");
    channel.postMessage({ type: "navigate", url: fullUrl });
    playerTab.focus();
  }
}
