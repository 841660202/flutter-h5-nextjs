'use client';
import { useCallback, useEffect, useRef, useState } from 'react';

export default function Home() {
  const [count, setCount] = useState(0);
  const vsconsole = useRef<any>();
  const vsconsoleShow = useRef(true);
  const [vconsoleEnable, setVconsoleEnable] = useState(true);
  const add = useCallback(() => {
    const newCount = count + 1;
    setCount(newCount);
    sendCount(newCount);
  }, [count]);

  const sendCount = useCallback((newCount: number) => {
    console.info('message ->>> flutter', newCount);
    window.flutter_inappwebview.callHandler('CountHandler', newCount + '');
  }, []);

  useEffect(() => {
    // or init with options
    if (typeof window !== 'undefined') {
      const Vconsole = require('vconsole');
      // or init with options
      vsconsole.current = new Vconsole({ theme: 'dark' });
    }
  }, []);
  useEffect(() => {
    // 定义从 Flutter 接收消息的函数
    window.fromFlutter = function (message: string) {
      // alert('Message from Flutter: ' + message);
      console.log('message ->>> flutter', message);
      if (message === 'toggle-vconsole') {
        toggleVconsole();
        return;
      }
      add();
    };
  }, [add, sendCount]);

  const toggleVconsole = useCallback(() => {
    if (vsconsoleShow.current) {
      vsconsole.current.hideSwitch();
    } else {
      vsconsole.current.showSwitch();
    }
    vsconsoleShow.current = !vsconsoleShow.current;
  }, []);

  const sendMessageToFlutter = () => {
    if (window.flutter_inappwebview) {
      window.flutter_inappwebview.callHandler('Toaster', 'Hello from Web!');
    }
  };

  const sendHideWebviewMessageToFlutter = () => {
    alert(1);
    if (window.flutter_inappwebview) {
      window.flutter_inappwebview.callHandler('toggleWebViewHandler');
    }
  };

  return (
    <div style={{ paddingTop: 140, zIndex: 999 }}>
      <h1>WebView Example</h1>
      <p style={{ marginTop: 10, marginBottom: 20 }}>在全局，被各个页面遮挡住了，不可以点击web页面按钮</p>
      <p>Count: {count}</p>
      <button onClick={sendMessageToFlutter}>Send Message to Flutter</button>
      <button onClick={sendHideWebviewMessageToFlutter}>Send toggleWebView Message to Flutter</button>
    </div>
  );
}
