import { AxiosPromise } from 'axios'
import client from './client'
import { Device } from '../../interfaces/index'

// getDevicesを実行した際のレスポンスデータの型
interface GetDevicesResponse {
  status: number
  devices: Device[]
  message: string
}

// createDeviceを実行した際のレスポンスデータの型
interface CreateDeviceResponse {
  status: number
  device: Device
  message: string
}

// deleteDeviceを実行した際のレスポンスデータの型
interface DeleteDeviceResponse {
  status: number
  device: Device
  message: string
}

// Device一覧を取得
export const getDevices = (): AxiosPromise<GetDevicesResponse> => {
  return client.get('/devices')
}

// Deviceを新規作成
export const createDevice = (data: Device): AxiosPromise<CreateDeviceResponse> => {
  return client.post('/devices', data)
}

// Deviceを削除
export const deleteDevice = (id: number): AxiosPromise<DeleteDeviceResponse> => {
  return client.delete(`/devices/${id}`)
}
