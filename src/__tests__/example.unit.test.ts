/**
 * 示例单元测试（模板）
 *
 * 说明：
 * 1) 采用 Arrange / Act / Assert 结构，便于阅读和维护。
 * 2) 用例命名聚焦“行为”，而不是实现细节。
 * 3) 新项目可直接复制该模式，替换为真实业务函数。
 */
describe('Example unit test', () => {
  it('should return expected sum', () => {
    // Arrange
    const a = 2;
    const b = 3;

    // Act
    const result = a + b;

    // Assert
    expect(result).toBe(5);
  });
});
