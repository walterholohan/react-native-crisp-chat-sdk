import React from 'react';
import { StyleSheet, View } from 'react-native';
import CrispButton from '../components/CrispButton';
import { configure, show } from 'react-native-crisp-chat-sdk';

export default function App() {
  configure('e93e073a-1f69-4cbc-8934-f9e1611d65bb');

  return (
    <View style={styles.container}>
      <CrispButton onPress={() => show()} />
    </View>
  );
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    alignItems: 'center',
    justifyContent: 'center',
    backgroundColor: 'white',
  },
});
