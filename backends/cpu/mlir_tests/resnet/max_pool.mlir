// Copyright 2020 The TensorFlow Runtime Authors
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//      http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

// This test is auto generated by: //utils/resnet/gen_max_pool_tests.py

// RUN: tfrt_translate -mlir-to-bef %s | bef_executor | FileCheck %s --dump-input=always

// CHECK-LABEL: --- Running 'test_max_pool_2d_f32_0'
func @test_max_pool_2d_f32_0() {
  %ch0 = hex.new.chain

  %path = "tfrt_test.get_string"() {
      value = "backends/cpu/mlir_tests/resnet/test_data/max_pool.btf"
  } : () -> !hex.string

  %input_index = hex.constant.i32 0
  %input = "btf.read_dense_tensor.f32.4"(%path, %input_index)
    : (!hex.string, i32) -> (!t.tensor)

  %expected_index = hex.constant.i32 1
  %expected = "btf.read_dense_tensor.f32.4"(%path, %expected_index)
    : (!hex.string, i32) -> (!t.tensor)

  %output = "dht.create_uninitialized_tensor.f32.4"() { shape = [2 : i64, 1 : i64, 1 : i64, 6 : i64] }
    : () -> !t.tensor
  %ch1 = "tfrt_test.max_pooling_2d.f32"(%input, %output, %ch0)
    { padding = "valid", pool_size = [3 : i32, 3 : i32], strides = [3 : i32, 3 : i32] }
    :  (!t.tensor, !t.tensor, !hex.chain) -> !hex.chain

  %cmp, %ch2 = "dht.tensor_allclose.f32"(%expected, %output, %ch1)
    : (!t.tensor, !t.tensor, !hex.chain) -> (i1, !hex.chain)

  // CHECK: int1 = 1
  hex.print.i1 %cmp, %ch2

  hex.return
}

// CHECK-LABEL: --- Running 'test_max_pool_2d_f32_1'
func @test_max_pool_2d_f32_1() {
  %ch0 = hex.new.chain

  %path = "tfrt_test.get_string"() {
      value = "backends/cpu/mlir_tests/resnet/test_data/max_pool.btf"
  } : () -> !hex.string

  %input_index = hex.constant.i32 2
  %input = "btf.read_dense_tensor.f32.4"(%path, %input_index)
    : (!hex.string, i32) -> (!t.tensor)

  %expected_index = hex.constant.i32 3
  %expected = "btf.read_dense_tensor.f32.4"(%path, %expected_index)
    : (!hex.string, i32) -> (!t.tensor)

  %output = "dht.create_uninitialized_tensor.f32.4"() { shape = [2 : i64, 3 : i64, 3 : i64, 6 : i64] }
    : () -> !t.tensor
  %ch1 = "tfrt_test.max_pooling_2d.f32"(%input, %output, %ch0)
    { padding = "same", pool_size = [3 : i32, 3 : i32], strides = [2 : i32, 2 : i32] }
    :  (!t.tensor, !t.tensor, !hex.chain) -> !hex.chain

  %cmp, %ch2 = "dht.tensor_allclose.f32"(%expected, %output, %ch1)
    : (!t.tensor, !t.tensor, !hex.chain) -> (i1, !hex.chain)

  // CHECK: int1 = 1
  hex.print.i1 %cmp, %ch2

  hex.return
}
