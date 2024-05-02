<template>
  <div id="app">
    <h1>弱弱MDM</h1>
    <form @submit.prevent>
      <input type="text" v-model="state.device_name">
      <input type="text" v-model="state.device_information">
      <button @click="handleCreateDevice">Add</button>
    </form>
    <p v-for="device in state.devices" v-bind:key="device.id">
      {{ device.device_name+" : "+device.device_name}} <button @click="handleDeleteDevice(device.id)">Delete</button>
    </p>
  </div>
</template>

<script lang="ts">
import { defineComponent, reactive, onMounted } from 'vue' // defineComponent関数（TypeScriptを取り入れる場合に必要）などを読み込む
import { getDevices, createDevice, deleteDevice } from './lib/api/devices' // APIを呼び出すための関数を読み込む
import { Device } from './interfaces/index' // 型定義を読み込む

interface State {
  devices: Device[]
  device_name: string
  device_information: string
}

export default defineComponent({
  setup() {
    const state = reactive<State>({
      devices: [],
      device_name: ''
    })

    // Device一覧を取得
    const handleGetDevices = async (): Promise<void> => {
      try {
        const res = await getDevices()

        if (res?.status === 200) {
          state.devices = res.data.devices // devices（配列）に結果を格納
        }
      } catch (err) {
        console.log(err)
      }
    }

    // Deviceを新規作成
    const handleCreateDevice = async (): Promise<void> => {
      if (state.device_name === '') return // 入力が空だった場合は以降の処理を行わない

      // Device型に沿ったデータを作成
      const data: Device = {
        device_name: state.device_name
      }

      try {
        const res = await createDevice(data)

        if (res?.status === 200) {
          state.devices = [...state.devices, res.data.device] // devices（配列）の最後尾にdeviceを追加
        } else {
          console.log(res.data.message)
        }
      } catch (err) {
        console.log(err)
      }

      state.device_name = '' // 追加後はdevice_nameを空にする（フォーム内がリセットされる）
    }

    // Deviceを削除
    const handleDeleteDevice = async (id: number): Promise<void> => {
      if (id == null) return // idが無かった場合は以降の処理を行わない

      try {
        const res = await deleteDevice(id)

        if (res?.status === 200) {
          state.devices = state.devices.filter(device => device.id !== id) // idが一致しないもののみに絞り込む（要するにidが一致したものを削除する）
        } else {
          console.log(res.data.message)
        }
      } catch (err) {
        console.log(err)
      }
    }

    // Vueインスタンスがマウントされるたびに実行される関数
    onMounted(() => {
      handleGetDevices()
    })

    // template内で使用したいものをreturn
    return {
      state,
      handleCreateDevice,
      handleDeleteDevice
    }
  }
})
</script>

<style>
#app {
  font-family: Avenir, Helvetica, Arial, sans-serif;
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
  text-align: center;
  color: #2c3e50;
  margin-top: 60px;
}
</style>
