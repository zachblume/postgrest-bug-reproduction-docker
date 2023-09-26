describe("My issue", () => {
  test("original", async () => {
    const url =
      "http://localhost:3000/interactions?select=*,people(*)&people.or=(first_name.ilike.%John%)&or=(people.not.is.null)";
    const result = await fetch(url);
    const json = await result.json();
    expect(json).toEqual([]);
  });
  test("minimal", async () => {
    const url =
      "http://localhost:3000/interactions?select=*,people(*)&people=not.is.null";
    const result = await fetch(url);
    const json = await result.json();
    expect(json).toEqual([]);
  });
});
